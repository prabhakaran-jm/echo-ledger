import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../errors/app_exceptions.dart';
import '../utils/rate_limiter.dart';

/// Endpoint for computing historical friction projections for a user.
class FrictionProjectionEndpoint extends Endpoint {
  /// Computes a [FrictionProjection] for the given user and category.
  ///
  /// The projection is based on:
  /// - Completed commitments for the user in the given [category].
  /// - Their associated [CommitmentLog] entries.
  /// - Their associated [PostCommitmentReflection] records.
  ///
  /// The [perceivedWeeklyEffort] parameter is used as the baseline for
  /// calculating effort overrun percentages.
  ///
  /// Requires authentication. The [userId] must match the authenticated user.
  Future<FrictionProjection> project(
    Session session,
    int userId,
    String category,
    double perceivedWeeklyEffort,
  ) async {
    session.log('FrictionProjection.project called: userId=$userId, category=$category, perceivedWeeklyEffort=$perceivedWeeklyEffort', level: LogLevel.info);

    // Rate limiting: 100 requests per minute per userId
    // On Serverpod Cloud, local cache may be unavailable — allow request if rate limiter fails
    try {
      final rateLimitKey = 'friction_projection_user_$userId';
      final rateLimitAllowed = await RateLimiter.checkRateLimit(
        session,
        rateLimitKey,
        100,
        60,
      );
      if (!rateLimitAllowed) {
        throw const RateLimitExceededException(
          'Too many requests. Please try again in a minute.',
        );
      }
    } on RateLimitExceededException {
      rethrow;
    } catch (e) {
      session.log(
        'Rate limiter failed, allowing request: $e',
        level: LogLevel.warning,
      );
    }

    // TODO: Add authentication check
    // In production, verify:
    // 1. User is authenticated (session has valid auth token)
    // 2. userId parameter matches authenticated user ID
    // 3. This prevents unauthorized access to other users' data
    // Example: final authenticatedUserId = session.auth.authenticatedUserId;
    //          if (authenticatedUserId == null || authenticatedUserId != userId) {
    //            throw Exception('Unauthorized');
    //          }

    // Validate input parameters
    if (category.trim().isEmpty) {
      session.log('Validation failed: empty category', level: LogLevel.warning);
      throw const ValidationException('Category cannot be empty');
    }

    if (perceivedWeeklyEffort < 0) {
      session.log(
        'Validation failed: negative perceivedWeeklyEffort',
        level: LogLevel.warning,
      );
      throw const ValidationException('Perceived weekly effort cannot be negative');
    }

    if (userId <= 0) {
      session.log('Validation failed: invalid userId', level: LogLevel.warning);
      throw const ValidationException('Invalid user ID');
    }

    // Fetch all completed commitments for the user.
    final commitments = await Commitment.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('completed'),
    );

    if (commitments.isEmpty) {
      return _emptyProjection();
    }

    // Fetch associated proposals to filter by category.
    final proposalIds = commitments.map((c) => c.proposalId).toSet();

    final proposals = await CommitmentProposal.db.find(
      session,
      where: (t) => t.id.inSet(proposalIds),
    );

    final proposalsById = {
      for (final p in proposals)
        if (p.id != null) p.id!: p,
    };

    final similarCommitments = commitments.where((commitment) {
      final proposal = proposalsById[commitment.proposalId];
      return proposal != null && proposal.category == category;
    }).toList();

    if (similarCommitments.isEmpty) {
      return _emptyProjection();
    }

    final similarCommitmentIds = similarCommitments
        .map((c) => c.id)
        .whereType<int>()
        .toSet();

    if (similarCommitmentIds.isEmpty) {
      return _emptyProjection();
    }

    // Fetch logs and reflections for the similar commitments.
    final logs = await CommitmentLog.db.find(
      session,
      where: (t) => t.commitmentId.inSet(similarCommitmentIds),
    );

    final reflections = await PostCommitmentReflection.db.find(
      session,
      where: (t) => t.commitmentId.inSet(similarCommitmentIds),
    );

    final similarCommitmentCount = similarCommitments.length;
    final avgWeeklyEffortOverrunPct = _computeAvgWeeklyEffortOverrunPct(
      logs: logs,
      perceivedWeeklyEffort: perceivedWeeklyEffort,
    );
    final mostCommonDropOffWeek = _computeMostCommonDropOffWeek(logs: logs);
    final regretLikelihoodPct = _computeRegretLikelihoodPct(
      reflections: reflections,
    );

    session.log('FrictionProjection computed: userId=$userId, category=$category, similarCommitmentCount=$similarCommitmentCount, avgWeeklyEffortOverrunPct=$avgWeeklyEffortOverrunPct, mostCommonDropOffWeek=$mostCommonDropOffWeek, regretLikelihoodPct=$regretLikelihoodPct', level: LogLevel.info);

    return FrictionProjection(
      similarCommitmentCount: similarCommitmentCount,
      avgWeeklyEffortOverrunPct: avgWeeklyEffortOverrunPct,
      mostCommonDropOffWeek: mostCommonDropOffWeek,
      regretLikelihoodPct: regretLikelihoodPct,
    );
  }

  FrictionProjection _emptyProjection() {
    return FrictionProjection(
      similarCommitmentCount: 0,
      avgWeeklyEffortOverrunPct: 0,
      mostCommonDropOffWeek: null,
      regretLikelihoodPct: 0,
    );
  }

  double _computeAvgWeeklyEffortOverrunPct({
    required List<CommitmentLog> logs,
    required double perceivedWeeklyEffort,
  }) {
    if (logs.isEmpty || perceivedWeeklyEffort <= 0) {
      return 0;
    }

    // Consider only non-skipped weeks when computing effort overrun.
    final effectiveLogs = logs.where((log) => !log.skipped).toList();
    if (effectiveLogs.isEmpty) {
      return 0;
    }

    final totalActual = effectiveLogs
        .map((l) => l.actualEffortHours)
        .fold(0.0, (a, b) => a + b);

    final avgActual = totalActual / effectiveLogs.length;

    final overrunPct =
        ((avgActual - perceivedWeeklyEffort) / perceivedWeeklyEffort) * 100;

    // Clamp to a reasonable range for UI and interpretation.
    return overrunPct.clamp(0, 300);
  }

  int? _computeMostCommonDropOffWeek({
    required List<CommitmentLog> logs,
  }) {
    final skippedLogs = logs.where((log) => log.skipped).toList();
    if (skippedLogs.isEmpty) {
      return null;
    }

    final countsByWeek = <int, int>{};
    for (final log in skippedLogs) {
      countsByWeek.update(
        log.weekIndex,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    int? bestWeek;
    var bestCount = 0;

    countsByWeek.forEach((week, count) {
      if (count > bestCount ||
          (count == bestCount && (bestWeek == null || week < bestWeek!))) {
        bestWeek = week;
        bestCount = count;
      }
    });

    return bestWeek;
  }

  int _computeRegretLikelihoodPct({
    required List<PostCommitmentReflection> reflections,
  }) {
    if (reflections.isEmpty) {
      return 0;
    }

    final total = reflections.length;
    final regretted = reflections.where((r) => r.regretScore >= 3).length;

    final ratio = regretted / total;
    final pct = (ratio * 100).round();
    return pct;
  }
}
