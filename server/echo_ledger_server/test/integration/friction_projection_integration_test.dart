import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Integration tests for the full friction projection flow:
/// 1. Seed data using the seed endpoint
/// 2. Call the friction projection endpoint
/// 3. Verify the results match expected values
void main() {
  withServerpod(
    'Given FrictionProjection integration flow',
    (sessionBuilder, endpoints) {
      test(
        'when seeding demo data then calling projection returns meaningful results',
        () async {
          // Step 1: Seed demo data using the seed endpoint
          final seedResult = await endpoints.seed.seedDemoData(sessionBuilder);
          expect(seedResult, contains('Demo data seeded successfully'));

          // Step 2: Call friction projection with parameters matching seeded data
          final userId = 1;
          final category = 'Learning';
          final perceivedWeeklyEffort = 5.0;

          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            userId,
            category,
            perceivedWeeklyEffort,
          );

          // Step 3: Verify results are meaningful (not all zeros)
          expect(projection.similarCommitmentCount, greaterThan(0));
          expect(projection.avgWeeklyEffortOverrunPct, greaterThanOrEqualTo(0));
          expect(projection.regretLikelihoodPct, greaterThanOrEqualTo(0));
          // mostCommonDropOffWeek can be null, which is valid

          // Verify specific expected values based on seeded data
          // Seeded data has 3 commitments, all in "Learning" category
          expect(projection.similarCommitmentCount, 3);

          // Seeded data has effort overruns (20%+ with increasing trend)
          expect(projection.avgWeeklyEffortOverrunPct, greaterThan(0));

          // Seeded data has 2 reflections with regretScore >= 3 out of 2 total
          // So regretLikelihoodPct should be 100%
          expect(projection.regretLikelihoodPct, 100);
        },
      );

      test(
        'when seeding data twice then second call is idempotent',
        () async {
          // First seed
          final firstResult =
              await endpoints.seed.seedDemoData(sessionBuilder);
          expect(firstResult, contains('Demo data seeded successfully'));

          // Second seed should detect existing data
          final secondResult =
              await endpoints.seed.seedDemoData(sessionBuilder);
          expect(secondResult, contains('already exists'));

          // Verify projection still works correctly
          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            1,
            'Learning',
            5.0,
          );

          // Should still have the same data
          expect(projection.similarCommitmentCount, 3);
        },
      );

      test(
        'when projecting with different category then returns empty projection',
        () async {
          // Seed data for "Learning" category
          await endpoints.seed.seedDemoData(sessionBuilder);

          // Project for different category
          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            1,
            'Fitness', // Different category
            5.0,
          );

          // Should return empty projection since no data matches
          expect(projection.similarCommitmentCount, 0);
          expect(projection.avgWeeklyEffortOverrunPct, 0);
          expect(projection.mostCommonDropOffWeek, isNull);
          expect(projection.regretLikelihoodPct, 0);
        },
      );

      test(
        'when projecting with different userId then returns empty projection',
        () async {
          // Seed data for userId 1
          await endpoints.seed.seedDemoData(sessionBuilder);

          // Project for different userId
          final projection = await endpoints.frictionProjection.project(
            sessionBuilder,
            999, // Different userId
            'Learning',
            5.0,
          );

          // Should return empty projection since no data matches
          expect(projection.similarCommitmentCount, 0);
          expect(projection.avgWeeklyEffortOverrunPct, 0);
          expect(projection.mostCommonDropOffWeek, isNull);
          expect(projection.regretLikelihoodPct, 0);
        },
      );

      test(
        'when projecting with different perceivedWeeklyEffort then overrun percentage changes',
        () async {
          // Seed data
          await endpoints.seed.seedDemoData(sessionBuilder);

          // Project with baseline perceived effort (5.0)
          final projection1 = await endpoints.frictionProjection.project(
            sessionBuilder,
            1,
            'Learning',
            5.0,
          );

          // Project with higher perceived effort (10.0)
          // This should result in lower overrun percentage
          final projection2 = await endpoints.frictionProjection.project(
            sessionBuilder,
            1,
            'Learning',
            10.0,
          );

          // Verify that overrun percentage is lower when perceived effort is higher
          // (same actual effort, but higher denominator)
          expect(projection2.avgWeeklyEffortOverrunPct,
              lessThan(projection1.avgWeeklyEffortOverrunPct));

          // Other metrics should remain the same
          expect(projection2.similarCommitmentCount,
              projection1.similarCommitmentCount);
          expect(projection2.mostCommonDropOffWeek,
              projection1.mostCommonDropOffWeek);
          expect(projection2.regretLikelihoodPct,
              projection1.regretLikelihoodPct);
        },
      );
    },
  );
}

