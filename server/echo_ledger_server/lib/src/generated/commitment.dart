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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Commitment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CommitmentTable();

  static const db = CommitmentRepository._();

  @override
  int? id;

  int userId;

  int proposalId;

  String status;

  DateTime startedAt;

  DateTime? endedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CommitmentInclude include() {
    return CommitmentInclude._();
  }

  static CommitmentIncludeList includeList({
    _i1.WhereExpressionBuilder<CommitmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentTable>? orderByList,
    CommitmentInclude? include,
  }) {
    return CommitmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Commitment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Commitment.t),
      include: include,
    );
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

class CommitmentUpdateTable extends _i1.UpdateTable<CommitmentTable> {
  CommitmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> proposalId(int value) => _i1.ColumnValue(
    table.proposalId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> endedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.endedAt,
        value,
      );
}

class CommitmentTable extends _i1.Table<int?> {
  CommitmentTable({super.tableRelation}) : super(tableName: 'commitment') {
    updateTable = CommitmentUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    proposalId = _i1.ColumnInt(
      'proposalId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    endedAt = _i1.ColumnDateTime(
      'endedAt',
      this,
    );
  }

  late final CommitmentUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt proposalId;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime endedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    proposalId,
    status,
    startedAt,
    endedAt,
  ];
}

class CommitmentInclude extends _i1.IncludeObject {
  CommitmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Commitment.t;
}

class CommitmentIncludeList extends _i1.IncludeList {
  CommitmentIncludeList._({
    _i1.WhereExpressionBuilder<CommitmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Commitment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Commitment.t;
}

class CommitmentRepository {
  const CommitmentRepository._();

  /// Returns a list of [Commitment]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Commitment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Commitment>(
      where: where?.call(Commitment.t),
      orderBy: orderBy?.call(Commitment.t),
      orderByList: orderByList?.call(Commitment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Commitment] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Commitment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommitmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Commitment>(
      where: where?.call(Commitment.t),
      orderBy: orderBy?.call(Commitment.t),
      orderByList: orderByList?.call(Commitment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Commitment] by its [id] or null if no such row exists.
  Future<Commitment?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Commitment>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Commitment]s in the list and returns the inserted rows.
  ///
  /// The returned [Commitment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Commitment>> insert(
    _i1.Session session,
    List<Commitment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Commitment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Commitment] and returns the inserted row.
  ///
  /// The returned [Commitment] will have its `id` field set.
  Future<Commitment> insertRow(
    _i1.Session session,
    Commitment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Commitment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Commitment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Commitment>> update(
    _i1.Session session,
    List<Commitment> rows, {
    _i1.ColumnSelections<CommitmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Commitment>(
      rows,
      columns: columns?.call(Commitment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Commitment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Commitment> updateRow(
    _i1.Session session,
    Commitment row, {
    _i1.ColumnSelections<CommitmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Commitment>(
      row,
      columns: columns?.call(Commitment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Commitment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Commitment?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CommitmentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Commitment>(
      id,
      columnValues: columnValues(Commitment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Commitment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Commitment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CommitmentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CommitmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentTable>? orderBy,
    _i1.OrderByListBuilder<CommitmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Commitment>(
      columnValues: columnValues(Commitment.t.updateTable),
      where: where(Commitment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Commitment.t),
      orderByList: orderByList?.call(Commitment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Commitment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Commitment>> delete(
    _i1.Session session,
    List<Commitment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Commitment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Commitment].
  Future<Commitment> deleteRow(
    _i1.Session session,
    Commitment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Commitment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Commitment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CommitmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Commitment>(
      where: where(Commitment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Commitment>(
      where: where?.call(Commitment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
