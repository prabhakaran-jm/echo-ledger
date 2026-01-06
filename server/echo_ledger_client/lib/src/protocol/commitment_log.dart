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

abstract class CommitmentLog implements _i1.SerializableModel {
  CommitmentLog._({
    this.id,
    required this.commitmentId,
    required this.weekIndex,
    required this.actualEffortHours,
    required this.frictionScore,
    required this.skipped,
    required this.createdAt,
  });

  factory CommitmentLog({
    int? id,
    required int commitmentId,
    required int weekIndex,
    required double actualEffortHours,
    required int frictionScore,
    required bool skipped,
    required DateTime createdAt,
  }) = _CommitmentLogImpl;

  factory CommitmentLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommitmentLog(
      id: jsonSerialization['id'] as int?,
      commitmentId: jsonSerialization['commitmentId'] as int,
      weekIndex: jsonSerialization['weekIndex'] as int,
      actualEffortHours: (jsonSerialization['actualEffortHours'] as num)
          .toDouble(),
      frictionScore: jsonSerialization['frictionScore'] as int,
      skipped: jsonSerialization['skipped'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int commitmentId;

  int weekIndex;

  double actualEffortHours;

  int frictionScore;

  bool skipped;

  DateTime createdAt;

  /// Returns a shallow copy of this [CommitmentLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommitmentLog copyWith({
    int? id,
    int? commitmentId,
    int? weekIndex,
    double? actualEffortHours,
    int? frictionScore,
    bool? skipped,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommitmentLog',
      if (id != null) 'id': id,
      'commitmentId': commitmentId,
      'weekIndex': weekIndex,
      'actualEffortHours': actualEffortHours,
      'frictionScore': frictionScore,
      'skipped': skipped,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommitmentLogImpl extends CommitmentLog {
  _CommitmentLogImpl({
    int? id,
    required int commitmentId,
    required int weekIndex,
    required double actualEffortHours,
    required int frictionScore,
    required bool skipped,
    required DateTime createdAt,
  }) : super._(
         id: id,
         commitmentId: commitmentId,
         weekIndex: weekIndex,
         actualEffortHours: actualEffortHours,
         frictionScore: frictionScore,
         skipped: skipped,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommitmentLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommitmentLog copyWith({
    Object? id = _Undefined,
    int? commitmentId,
    int? weekIndex,
    double? actualEffortHours,
    int? frictionScore,
    bool? skipped,
    DateTime? createdAt,
  }) {
    return CommitmentLog(
      id: id is int? ? id : this.id,
      commitmentId: commitmentId ?? this.commitmentId,
      weekIndex: weekIndex ?? this.weekIndex,
      actualEffortHours: actualEffortHours ?? this.actualEffortHours,
      frictionScore: frictionScore ?? this.frictionScore,
      skipped: skipped ?? this.skipped,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
