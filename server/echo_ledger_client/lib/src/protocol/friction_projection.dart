/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class FrictionProjection implements _i1.SerializableModel {
  FrictionProjection._({
    required this.similarCommitmentCount,
    required this.avgWeeklyEffortOverrunPct,
    this.mostCommonDropOffWeek,
    required this.regretLikelihoodPct,
  });

  factory FrictionProjection({
    required int similarCommitmentCount,
    required double avgWeeklyEffortOverrunPct,
    int? mostCommonDropOffWeek,
    required int regretLikelihoodPct,
  }) = _FrictionProjectionImpl;

  factory FrictionProjection.fromJson(Map<String, dynamic> jsonSerialization) {
    return FrictionProjection(
      similarCommitmentCount:
          jsonSerialization['similarCommitmentCount'] as int,
      avgWeeklyEffortOverrunPct:
          (jsonSerialization['avgWeeklyEffortOverrunPct'] as num).toDouble(),
      mostCommonDropOffWeek: jsonSerialization['mostCommonDropOffWeek'] as int?,
      regretLikelihoodPct: jsonSerialization['regretLikelihoodPct'] as int,
    );
  }

  int similarCommitmentCount;

  double avgWeeklyEffortOverrunPct;

  int? mostCommonDropOffWeek;

  int regretLikelihoodPct;

  /// Returns a shallow copy of this [FrictionProjection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FrictionProjection copyWith({
    int? similarCommitmentCount,
    double? avgWeeklyEffortOverrunPct,
    int? mostCommonDropOffWeek,
    int? regretLikelihoodPct,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FrictionProjection',
      'similarCommitmentCount': similarCommitmentCount,
      'avgWeeklyEffortOverrunPct': avgWeeklyEffortOverrunPct,
      if (mostCommonDropOffWeek != null)
        'mostCommonDropOffWeek': mostCommonDropOffWeek,
      'regretLikelihoodPct': regretLikelihoodPct,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FrictionProjectionImpl extends FrictionProjection {
  _FrictionProjectionImpl({
    required int similarCommitmentCount,
    required double avgWeeklyEffortOverrunPct,
    int? mostCommonDropOffWeek,
    required int regretLikelihoodPct,
  }) : super._(
         similarCommitmentCount: similarCommitmentCount,
         avgWeeklyEffortOverrunPct: avgWeeklyEffortOverrunPct,
         mostCommonDropOffWeek: mostCommonDropOffWeek,
         regretLikelihoodPct: regretLikelihoodPct,
       );

  /// Returns a shallow copy of this [FrictionProjection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FrictionProjection copyWith({
    int? similarCommitmentCount,
    double? avgWeeklyEffortOverrunPct,
    Object? mostCommonDropOffWeek = _Undefined,
    int? regretLikelihoodPct,
  }) {
    return FrictionProjection(
      similarCommitmentCount:
          similarCommitmentCount ?? this.similarCommitmentCount,
      avgWeeklyEffortOverrunPct:
          avgWeeklyEffortOverrunPct ?? this.avgWeeklyEffortOverrunPct,
      mostCommonDropOffWeek: mostCommonDropOffWeek is int?
          ? mostCommonDropOffWeek
          : this.mostCommonDropOffWeek,
      regretLikelihoodPct: regretLikelihoodPct ?? this.regretLikelihoodPct,
    );
  }
}
