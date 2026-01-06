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

abstract class Commitment implements _i1.SerializableModel {
  Commitment._({
    this.id,
    required this.userId,
    required this.proposalId,
    required this.status,
    required this.startedAt,
    this.endedAt,
  });

  factory Commitment({
    int? id,
    required int userId,
    required int proposalId,
    required String status,
    required DateTime startedAt,
    DateTime? endedAt,
  }) = _CommitmentImpl;

  factory Commitment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Commitment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      proposalId: jsonSerialization['proposalId'] as int,
      status: jsonSerialization['status'] as String,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int proposalId;

  String status;

  DateTime startedAt;

  DateTime? endedAt;

  /// Returns a shallow copy of this [Commitment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Commitment copyWith({
    int? id,
    int? userId,
    int? proposalId,
    String? status,
    DateTime? startedAt,
    DateTime? endedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Commitment',
      if (id != null) 'id': id,
      'userId': userId,
      'proposalId': proposalId,
      'status': status,
      'startedAt': startedAt.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommitmentImpl extends Commitment {
  _CommitmentImpl({
    int? id,
    required int userId,
    required int proposalId,
    required String status,
    required DateTime startedAt,
    DateTime? endedAt,
  }) : super._(
         id: id,
         userId: userId,
         proposalId: proposalId,
         status: status,
         startedAt: startedAt,
         endedAt: endedAt,
       );

  /// Returns a shallow copy of this [Commitment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Commitment copyWith({
    Object? id = _Undefined,
    int? userId,
    int? proposalId,
    String? status,
    DateTime? startedAt,
    Object? endedAt = _Undefined,
  }) {
    return Commitment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      proposalId: proposalId ?? this.proposalId,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
    );
  }
}
