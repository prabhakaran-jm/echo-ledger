import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../errors/app_exceptions.dart';

/// Temporary endpoint for seeding demo data.
/// Only available in development mode.
/// Remove this endpoint before production.
class SeedEndpoint extends Endpoint {
  /// Seeds minimal demo data for friction projection testing.
  ///
  /// Creates:
  /// - 3 completed commitments in "Learning" category
  /// - Logs with skipped weeks and effort overruns
  /// - Reflections with regret scores >= 3
  ///
  /// Idempotent: safe to call multiple times.
  ///
  /// Only available in development mode. Throws an exception in production.
  Future<String> seedDemoData(Session session) async {
    session.log('SeedEndpoint.seedDemoData called', level: LogLevel.info);

    // Protect this endpoint - only allow in development or on Serverpod Cloud (for hackathon demo)
    final host = session.serverpod.config.apiServer.publicHost;
    final isHttps = session.serverpod.config.apiServer.publicScheme == 'https';
    final isLocalhost = host == 'localhost' || host.startsWith('127.');
    final isServerpodCloud = host.contains('serverpod.space');

    // Allow: localhost (dev) or Serverpod Cloud (hackathon demo). Block other production.
    if (isHttps && !isLocalhost && !isServerpodCloud) {
      throw const OperationNotAllowedException(
        'Seed endpoint is disabled in production',
      );
    }
    // Check if data already exists
    final existingProposals = await CommitmentProposal.db.find(
      session,
      where: (t) => t.category.equals('Learning'),
      limit: 1,
    );

    if (existingProposals.isNotEmpty) {
      session.log(
        'Demo data already exists, skipping seed',
        level: LogLevel.info,
      );
      return 'Demo data already exists. Skipping seed.';
    }

    final userId = 1;
    final now = DateTime.now();
    final category = 'Learning';
    final perceivedWeeklyEffort = 5.0; // Baseline for comparison

    // Create 3 proposals
    final proposals = await CommitmentProposal.db.insert(
      session,
      [
        CommitmentProposal(
          userId: userId,
          title: 'Learn Flutter State Management',
          category: category,
          perceivedWeeklyEffort: perceivedWeeklyEffort,
          perceivedDurationWeeks: 4,
          effortType: 'time',
          createdAt: now.subtract(const Duration(days: 90)),
        ),
        CommitmentProposal(
          userId: userId,
          title: 'Master Dart Async Programming',
          category: category,
          perceivedWeeklyEffort: perceivedWeeklyEffort,
          perceivedDurationWeeks: 6,
          effortType: 'time',
          createdAt: now.subtract(const Duration(days: 60)),
        ),
        CommitmentProposal(
          userId: userId,
          title: 'Build Serverpod Backend',
          category: category,
          perceivedWeeklyEffort: perceivedWeeklyEffort,
          perceivedDurationWeeks: 8,
          effortType: 'time',
          createdAt: now.subtract(const Duration(days: 30)),
        ),
      ],
    );

    // Create completed commitments
    final commitments = await Commitment.db.insert(
      session,
      proposals.map((proposal) {
        final proposalCreated = proposal.createdAt;
        final startedAt = proposalCreated.add(const Duration(days: 7));
        final endedAt = startedAt.add(
          Duration(
            days: proposal.perceivedDurationWeeks * 7,
          ),
        );

        return Commitment(
          userId: userId,
          proposalId: proposal.id!,
          status: 'completed',
          startedAt: startedAt,
          endedAt: endedAt,
        );
      }).toList(),
    );

    // Create logs with effort overruns and skipped weeks
    final logs = <CommitmentLog>[];
    for (var i = 0; i < commitments.length; i++) {
      final commitment = commitments[i];
      final commitmentStarted = commitment.startedAt;
      final weeks = commitments[i].proposalId == proposals[0].id!
          ? 4
          : commitments[i].proposalId == proposals[1].id!
          ? 6
          : 8;

      for (var week = 0; week < weeks; week++) {
        final weekStarted = commitmentStarted.add(Duration(days: week * 7));
        final isSkipped =
            (week == 2 || week == 5) &&
            i < 2; // Skip weeks 2 and 5 for first 2 commitments
        final actualEffort = isSkipped
            ? 0.0
            : perceivedWeeklyEffort *
                  (1.2 + (week * 0.1)); // 20%+ overrun, increasing

        logs.add(
          CommitmentLog(
            commitmentId: commitment.id!,
            weekIndex: week,
            actualEffortHours: actualEffort,
            frictionScore: isSkipped
                ? 5
                : (actualEffort > perceivedWeeklyEffort ? 3 : 1),
            skipped: isSkipped,
            createdAt: weekStarted,
          ),
        );
      }
    }

    await CommitmentLog.db.insert(session, logs);

    // Create reflections with regret scores >= 3
    await PostCommitmentReflection.db.insert(
      session,
      [
        PostCommitmentReflection(
          commitmentId: commitments[0].id!,
          regretScore: 4, // High regret
          satisfactionScore: 2,
          wouldRepeat: 'no',
          notes: 'Took more time than expected, felt rushed',
          createdAt: commitments[0].endedAt!.add(const Duration(days: 1)),
        ),
        PostCommitmentReflection(
          commitmentId: commitments[1].id!,
          regretScore: 3, // Moderate regret
          satisfactionScore: 3,
          wouldRepeat: 'maybe',
          notes: 'Challenging but learned a lot',
          createdAt: commitments[1].endedAt!.add(const Duration(days: 1)),
        ),
      ],
    );

    final result =
        'Demo data seeded successfully: ${proposals.length} proposals, ${commitments.length} commitments, ${logs.length} logs, 2 reflections';
    session.log(
      'Demo data seeded successfully: proposals=${proposals.length}, commitments=${commitments.length}, logs=${logs.length}, reflections=2',
      level: LogLevel.info,
    );
    return result;
  }

  /// Clears demo data for userId=1, category=Learning so you can re-seed for demo video.
  /// Uses the same host/safety checks as [seedDemoData].
  Future<String> clearDemoData(Session session) async {
    session.log('SeedEndpoint.clearDemoData called', level: LogLevel.info);

    final host = session.serverpod.config.apiServer.publicHost;
    final isHttps = session.serverpod.config.apiServer.publicScheme == 'https';
    final isLocalhost = host == 'localhost' || host.startsWith('127.');
    final isServerpodCloud = host.contains('serverpod.space');

    if (isHttps && !isLocalhost && !isServerpodCloud) {
      throw const OperationNotAllowedException(
        'Clear demo endpoint is disabled in production',
      );
    }

    const demoUserId = 1;
    const demoCategory = 'Learning';

    final proposals = await CommitmentProposal.db.find(
      session,
      where: (t) =>
          t.userId.equals(demoUserId) & t.category.equals(demoCategory),
    );
    if (proposals.isEmpty) {
      session.log('No demo data to clear', level: LogLevel.info);
      return 'No demo data to clear. Seed first, then you can clear.';
    }

    final proposalIds = proposals.map((p) => p.id!).toSet();
    final commitments = await Commitment.db.find(
      session,
      where: (t) => t.proposalId.inSet(proposalIds),
    );
    final commitmentIds = commitments.map((c) => c.id!).toSet();

    await PostCommitmentReflection.db.deleteWhere(
      session,
      where: (t) => t.commitmentId.inSet(commitmentIds),
    );
    await CommitmentLog.db.deleteWhere(
      session,
      where: (t) => t.commitmentId.inSet(commitmentIds),
    );
    await Commitment.db.deleteWhere(
      session,
      where: (t) => t.proposalId.inSet(proposalIds),
    );
    await CommitmentProposal.db.deleteWhere(
      session,
      where: (t) => t.id.inSet(proposalIds),
    );

    session.log(
      'Demo data cleared: ${proposalIds.length} proposals, ${commitmentIds.length} commitments',
      level: LogLevel.info,
    );
    return 'Demo data cleared. You can seed again for a fresh demo.';
  }
}
