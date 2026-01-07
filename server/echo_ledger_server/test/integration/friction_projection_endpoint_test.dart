import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';
import 'package:echo_ledger_server/src/generated/protocol.dart';

void main() {
  withServerpod(
    'Given FrictionProjectionEndpoint',
    (sessionBuilder, endpoints) {
      test(
        'when computing effort overrun with actual > perceived then returns positive percentage',
        () async {
          // Setup: Create a completed commitment with logs showing effort overrun
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();

          // Get a session for database operations
          final session = sessionBuilder.build();

          // Create proposal
          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 4,
              effortType: 'time',
              createdAt: now,
            ),
          );

          // Create completed commitment
          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 28)),
              endedAt: now,
            ),
          );

          // Create logs with actual effort > perceived (6 hours vs 5 hours = 20% overrun)
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 6.0, // 20% overrun
                frictionScore: 3,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 0)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 1,
                actualEffortHours: 6.0, // 20% overrun
                frictionScore: 3,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 7)),
              ),
            ],
          );

          // Call endpoint
          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: Average actual = 6.0, perceived = 5.0, overrun = (6-5)/5 * 100 = 20%
          expect(projection.avgWeeklyEffortOverrunPct, closeTo(20.0, 0.1));
          expect(projection.similarCommitmentCount, 1);
        },
      );

      test(
        'when computing effort overrun with actual < perceived then returns 0 (clamped)',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          // Create logs with actual effort < perceived (4 hours vs 5 hours)
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 4.0, // Less than perceived
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted,
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: Negative overrun is clamped to 0
          expect(projection.avgWeeklyEffortOverrunPct, 0);
        },
      );

      test(
        'when computing most common drop-off week then returns the week with most skipped logs',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 6,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 42)),
              endedAt: now,
            ),
          );

          // Create logs: week 2 skipped twice, week 3 skipped once
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 0)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 1,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 7)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 2,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true, // Skipped
                createdAt: commitmentStarted.add(const Duration(days: 14)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 2,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true, // Skipped again (same week)
                createdAt: commitmentStarted.add(const Duration(days: 14)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 3,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true, // Skipped once
                createdAt: commitmentStarted.add(const Duration(days: 21)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: Week 2 has 2 skipped logs, so it should be the most common
          expect(projection.mostCommonDropOffWeek, 2);
        },
      );

      test(
        'when no skipped logs exist then mostCommonDropOffWeek is null',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          // Create logs with no skipped weeks
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted,
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 1,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 7)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: No skipped logs, so mostCommonDropOffWeek should be null
          expect(projection.mostCommonDropOffWeek, isNull);
        },
      );

      test(
        'when computing regret likelihood then returns percentage of reflections with regretScore >= 3',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          // Create reflections: 2 with regretScore >= 3, 1 with regretScore < 3
          // Expected: 2/3 = 66.67% -> rounds to 67%
          final commitmentEnded = commitment.endedAt ?? now;
          await PostCommitmentReflection.db.insert(
            session,
            [
              PostCommitmentReflection(
                commitmentId: commitment.id!,
                regretScore: 4, // >= 3
                satisfactionScore: 2,
                wouldRepeat: 'no',
                notes: 'High regret',
                createdAt: commitmentEnded.add(const Duration(days: 1)),
              ),
              PostCommitmentReflection(
                commitmentId: commitment.id!,
                regretScore: 3, // >= 3
                satisfactionScore: 3,
                wouldRepeat: 'maybe',
                notes: 'Moderate regret',
                createdAt: commitmentEnded.add(const Duration(days: 2)),
              ),
              PostCommitmentReflection(
                commitmentId: commitment.id!,
                regretScore: 2, // < 3
                satisfactionScore: 4,
                wouldRepeat: 'yes',
                notes: 'Low regret',
                createdAt: commitmentEnded.add(const Duration(days: 3)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: 2 out of 3 reflections have regretScore >= 3 = 66.67% -> 67%
          expect(projection.regretLikelihoodPct, 67);
        },
      );

      test(
        'when no completed commitments exist then returns empty projection',
        () async {
          final userId = 999; // Non-existent user
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Verify: Empty projection with all zeros/null
          expect(projection.similarCommitmentCount, 0);
          expect(projection.avgWeeklyEffortOverrunPct, 0);
          expect(projection.mostCommonDropOffWeek, isNull);
          expect(projection.regretLikelihoodPct, 0);
        },
      );

      test(
        'when input validation fails then throws ValidationException',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;

          // Test empty category
          expect(
            () => endpoints.frictionProjection.project(
              sessionBuilder,
              userId,
              '', // Empty category
              perceivedWeeklyEffort,
            ),
            throwsA(isA<Exception>()),
          );

          // Test negative perceived weekly effort
          expect(
            () => endpoints.frictionProjection.project(
              sessionBuilder,
              userId,
              category,
              -1.0, // Negative
            ),
            throwsA(isA<Exception>()),
          );

          // Test invalid userId
          expect(
            () => endpoints.frictionProjection.project(
              sessionBuilder,
              0, // Invalid userId
              category,
              perceivedWeeklyEffort,
            ),
            throwsA(isA<Exception>()),
          );
        },
      );

      // Edge case tests
      test(
        'when all logs are skipped then avgWeeklyEffortOverrunPct is 0',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          // All logs are skipped
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true,
                createdAt: commitmentStarted,
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 1,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true,
                createdAt: commitmentStarted.add(const Duration(days: 7)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // When all logs are skipped, effectiveLogs is empty, so overrun is 0
          expect(projection.avgWeeklyEffortOverrunPct, 0);
          // But mostCommonDropOffWeek should still be computed
          expect(projection.mostCommonDropOffWeek, isNotNull);
        },
      );

      test(
        'when perceivedWeeklyEffort is 0 then avgWeeklyEffortOverrunPct is 0',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 0.0; // Edge case: zero effort
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: 5.0, // Proposal has non-zero
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted,
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort, // Zero perceived effort
          );

          // Division by zero protection: should return 0
          expect(projection.avgWeeklyEffortOverrunPct, 0);
        },
      );

      test(
        'when effort overrun exceeds 300% then it is clamped to 300%',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 1.0; // Very low perceived
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 1,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 7)),
              endedAt: now,
            ),
          );

          // Actual effort is 5.0, perceived is 1.0 = 400% overrun
          // Should be clamped to 300%
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 5.0, // 400% overrun
                frictionScore: 5,
                skipped: false,
                createdAt: commitmentStarted,
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Should be clamped to 300%
          expect(projection.avgWeeklyEffortOverrunPct, 300);
        },
      );

      test(
        'when multiple weeks have same skip count then returns earliest week',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 4,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 28)),
              endedAt: now,
            ),
          );

          // Week 1 and week 3 both have 1 skip each
          // Should return week 1 (earliest)
          final commitmentStarted = commitment.startedAt;
          await CommitmentLog.db.insert(
            session,
            [
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 0,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 0)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 1,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true, // Skipped
                createdAt: commitmentStarted.add(const Duration(days: 7)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 2,
                actualEffortHours: 5.0,
                frictionScore: 1,
                skipped: false,
                createdAt: commitmentStarted.add(const Duration(days: 14)),
              ),
              CommitmentLog(
                commitmentId: commitment.id!,
                weekIndex: 3,
                actualEffortHours: 0.0,
                frictionScore: 5,
                skipped: true, // Also skipped
                createdAt: commitmentStarted.add(const Duration(days: 21)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Both week 1 and week 3 have 1 skip, should return week 1 (earliest)
          expect(projection.mostCommonDropOffWeek, 1);
        },
      );

      test(
        'when all reflections have regretScore < 3 then regretLikelihoodPct is 0',
        () async {
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;
          final now = DateTime.now();
          final session = sessionBuilder.build();

          final proposal = await CommitmentProposal.db.insertRow(
            session,
            CommitmentProposal(
              userId: userId,
              title: 'Test Commitment',
              category: category,
              perceivedWeeklyEffort: perceivedWeeklyEffort,
              perceivedDurationWeeks: 2,
              effortType: 'time',
              createdAt: now,
            ),
          );

          final commitment = await Commitment.db.insertRow(
            session,
            Commitment(
              userId: userId,
              proposalId: proposal.id!,
              status: 'completed',
              startedAt: now.subtract(const Duration(days: 14)),
              endedAt: now,
            ),
          );

          // All reflections have regretScore < 3
          final commitmentEnded = commitment.endedAt ?? now;
          await PostCommitmentReflection.db.insert(
            session,
            [
              PostCommitmentReflection(
                commitmentId: commitment.id!,
                regretScore: 1, // < 3
                satisfactionScore: 5,
                wouldRepeat: 'yes',
                notes: 'No regret',
                createdAt: commitmentEnded.add(const Duration(days: 1)),
              ),
              PostCommitmentReflection(
                commitmentId: commitment.id!,
                regretScore: 2, // < 3
                satisfactionScore: 4,
                wouldRepeat: 'yes',
                notes: 'Low regret',
                createdAt: commitmentEnded.add(const Duration(days: 2)),
              ),
            ],
          );

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // No reflections with regretScore >= 3, so should be 0%
          expect(projection.regretLikelihoodPct, 0);
        },
      );
    },
  );
}

