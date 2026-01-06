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

abstract class CommitmentProposal implements _i1.SerializableModel {
  CommitmentProposal._({
    this.id,
    required this.userId,
    required this.title,
    required this.category,
    required this.perceivedWeeklyEffort,
    required this.perceivedDurationWeeks,
    required this.effortType,
    required this.createdAt,
  });

  factory CommitmentProposal({
    int? id,
    required int userId,
    required String title,
    required String category,
    required double perceivedWeeklyEffort,
    required int perceivedDurationWeeks,
    required String effortType,
    required DateTime createdAt,
  }) = _CommitmentProposalImpl;

  factory CommitmentProposal.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommitmentProposal(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      category: jsonSerialization['category'] as String,
      perceivedWeeklyEffort: (jsonSerialization['perceivedWeeklyEffort'] as num)
          .toDouble(),
      perceivedDurationWeeks:
          jsonSerialization['perceivedDurationWeeks'] as int,
      effortType: jsonSerialization['effortType'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  String category;

  double perceivedWeeklyEffort;

  int perceivedDurationWeeks;

  String effortType;

  DateTime createdAt;

  /// Returns a shallow copy of this [CommitmentProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommitmentProposal copyWith({
    int? id,
    int? userId,
    String? title,
    String? category,
    double? perceivedWeeklyEffort,
    int? perceivedDurationWeeks,
    String? effortType,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommitmentProposal',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'category': category,
      'perceivedWeeklyEffort': perceivedWeeklyEffort,
      'perceivedDurationWeeks': perceivedDurationWeeks,
      'effortType': effortType,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommitmentProposalImpl extends CommitmentProposal {
  _CommitmentProposalImpl({
    int? id,
    required int userId,
    required String title,
    required String category,
    required double perceivedWeeklyEffort,
    required int perceivedDurationWeeks,
    required String effortType,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         category: category,
         perceivedWeeklyEffort: perceivedWeeklyEffort,
         perceivedDurationWeeks: perceivedDurationWeeks,
         effortType: effortType,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommitmentProposal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommitmentProposal copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? category,
    double? perceivedWeeklyEffort,
    int? perceivedDurationWeeks,
    String? effortType,
    DateTime? createdAt,
  }) {
    return CommitmentProposal(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      category: category ?? this.category,
      perceivedWeeklyEffort:
          perceivedWeeklyEffort ?? this.perceivedWeeklyEffort,
      perceivedDurationWeeks:
          perceivedDurationWeeks ?? this.perceivedDurationWeeks,
      effortType: effortType ?? this.effortType,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
