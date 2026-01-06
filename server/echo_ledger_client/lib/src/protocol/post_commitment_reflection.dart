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

abstract class PostCommitmentReflection implements _i1.SerializableModel {
  PostCommitmentReflection._({
    this.id,
    required this.commitmentId,
    required this.regretScore,
    required this.satisfactionScore,
    required this.wouldRepeat,
    this.notes,
    required this.createdAt,
  });

  factory PostCommitmentReflection({
    int? id,
    required int commitmentId,
    required int regretScore,
    required int satisfactionScore,
    required String wouldRepeat,
    String? notes,
    required DateTime createdAt,
  }) = _PostCommitmentReflectionImpl;

  factory PostCommitmentReflection.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PostCommitmentReflection(
      id: jsonSerialization['id'] as int?,
      commitmentId: jsonSerialization['commitmentId'] as int,
      regretScore: jsonSerialization['regretScore'] as int,
      satisfactionScore: jsonSerialization['satisfactionScore'] as int,
      wouldRepeat: jsonSerialization['wouldRepeat'] as String,
      notes: jsonSerialization['notes'] as String?,
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

  int regretScore;

  int satisfactionScore;

  String wouldRepeat;

  String? notes;

  DateTime createdAt;

  /// Returns a shallow copy of this [PostCommitmentReflection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PostCommitmentReflection copyWith({
    int? id,
    int? commitmentId,
    int? regretScore,
    int? satisfactionScore,
    String? wouldRepeat,
    String? notes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostCommitmentReflection',
      if (id != null) 'id': id,
      'commitmentId': commitmentId,
      'regretScore': regretScore,
      'satisfactionScore': satisfactionScore,
      'wouldRepeat': wouldRepeat,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostCommitmentReflectionImpl extends PostCommitmentReflection {
  _PostCommitmentReflectionImpl({
    int? id,
    required int commitmentId,
    required int regretScore,
    required int satisfactionScore,
    required String wouldRepeat,
    String? notes,
    required DateTime createdAt,
  }) : super._(
         id: id,
         commitmentId: commitmentId,
         regretScore: regretScore,
         satisfactionScore: satisfactionScore,
         wouldRepeat: wouldRepeat,
         notes: notes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PostCommitmentReflection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PostCommitmentReflection copyWith({
    Object? id = _Undefined,
    int? commitmentId,
    int? regretScore,
    int? satisfactionScore,
    String? wouldRepeat,
    Object? notes = _Undefined,
    DateTime? createdAt,
  }) {
    return PostCommitmentReflection(
      id: id is int? ? id : this.id,
      commitmentId: commitmentId ?? this.commitmentId,
      regretScore: regretScore ?? this.regretScore,
      satisfactionScore: satisfactionScore ?? this.satisfactionScore,
      wouldRepeat: wouldRepeat ?? this.wouldRepeat,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
