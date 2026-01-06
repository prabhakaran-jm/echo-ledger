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

abstract class CommitmentLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CommitmentLogTable();

  static const db = CommitmentLogRepository._();

  @override
  int? id;

  int commitmentId;

  int weekIndex;

  double actualEffortHours;

  int frictionScore;

  bool skipped;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CommitmentLogInclude include() {
    return CommitmentLogInclude._();
  }

  static CommitmentLogIncludeList includeList({
    _i1.WhereExpressionBuilder<CommitmentLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentLogTable>? orderByList,
    CommitmentLogInclude? include,
  }) {
    return CommitmentLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommitmentLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommitmentLog.t),
      include: include,
    );
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

class CommitmentLogUpdateTable extends _i1.UpdateTable<CommitmentLogTable> {
  CommitmentLogUpdateTable(super.table);

  _i1.ColumnValue<int, int> commitmentId(int value) => _i1.ColumnValue(
    table.commitmentId,
    value,
  );

  _i1.ColumnValue<int, int> weekIndex(int value) => _i1.ColumnValue(
    table.weekIndex,
    value,
  );

  _i1.ColumnValue<double, double> actualEffortHours(double value) =>
      _i1.ColumnValue(
        table.actualEffortHours,
        value,
      );

  _i1.ColumnValue<int, int> frictionScore(int value) => _i1.ColumnValue(
    table.frictionScore,
    value,
  );

  _i1.ColumnValue<bool, bool> skipped(bool value) => _i1.ColumnValue(
    table.skipped,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CommitmentLogTable extends _i1.Table<int?> {
  CommitmentLogTable({super.tableRelation})
    : super(tableName: 'commitment_log') {
    updateTable = CommitmentLogUpdateTable(this);
    commitmentId = _i1.ColumnInt(
      'commitmentId',
      this,
    );
    weekIndex = _i1.ColumnInt(
      'weekIndex',
      this,
    );
    actualEffortHours = _i1.ColumnDouble(
      'actualEffortHours',
      this,
    );
    frictionScore = _i1.ColumnInt(
      'frictionScore',
      this,
    );
    skipped = _i1.ColumnBool(
      'skipped',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CommitmentLogUpdateTable updateTable;

  late final _i1.ColumnInt commitmentId;

  late final _i1.ColumnInt weekIndex;

  late final _i1.ColumnDouble actualEffortHours;

  late final _i1.ColumnInt frictionScore;

  late final _i1.ColumnBool skipped;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    commitmentId,
    weekIndex,
    actualEffortHours,
    frictionScore,
    skipped,
    createdAt,
  ];
}

class CommitmentLogInclude extends _i1.IncludeObject {
  CommitmentLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommitmentLog.t;
}

class CommitmentLogIncludeList extends _i1.IncludeList {
  CommitmentLogIncludeList._({
    _i1.WhereExpressionBuilder<CommitmentLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommitmentLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommitmentLog.t;
}

class CommitmentLogRepository {
  const CommitmentLogRepository._();

  /// Returns a list of [CommitmentLog]s matching the given query parameters.
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
  Future<List<CommitmentLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CommitmentLog>(
      where: where?.call(CommitmentLog.t),
      orderBy: orderBy?.call(CommitmentLog.t),
      orderByList: orderByList?.call(CommitmentLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CommitmentLog] matching the given query parameters.
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
  Future<CommitmentLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommitmentLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CommitmentLog>(
      where: where?.call(CommitmentLog.t),
      orderBy: orderBy?.call(CommitmentLog.t),
      orderByList: orderByList?.call(CommitmentLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CommitmentLog] by its [id] or null if no such row exists.
  Future<CommitmentLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CommitmentLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CommitmentLog]s in the list and returns the inserted rows.
  ///
  /// The returned [CommitmentLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CommitmentLog>> insert(
    _i1.Session session,
    List<CommitmentLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CommitmentLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CommitmentLog] and returns the inserted row.
  ///
  /// The returned [CommitmentLog] will have its `id` field set.
  Future<CommitmentLog> insertRow(
    _i1.Session session,
    CommitmentLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommitmentLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommitmentLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommitmentLog>> update(
    _i1.Session session,
    List<CommitmentLog> rows, {
    _i1.ColumnSelections<CommitmentLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommitmentLog>(
      rows,
      columns: columns?.call(CommitmentLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommitmentLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommitmentLog> updateRow(
    _i1.Session session,
    CommitmentLog row, {
    _i1.ColumnSelections<CommitmentLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommitmentLog>(
      row,
      columns: columns?.call(CommitmentLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommitmentLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommitmentLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CommitmentLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CommitmentLog>(
      id,
      columnValues: columnValues(CommitmentLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommitmentLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CommitmentLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CommitmentLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CommitmentLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentLogTable>? orderBy,
    _i1.OrderByListBuilder<CommitmentLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CommitmentLog>(
      columnValues: columnValues(CommitmentLog.t.updateTable),
      where: where(CommitmentLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommitmentLog.t),
      orderByList: orderByList?.call(CommitmentLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CommitmentLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommitmentLog>> delete(
    _i1.Session session,
    List<CommitmentLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommitmentLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommitmentLog].
  Future<CommitmentLog> deleteRow(
    _i1.Session session,
    CommitmentLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommitmentLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommitmentLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CommitmentLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommitmentLog>(
      where: where(CommitmentLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommitmentLog>(
      where: where?.call(CommitmentLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
