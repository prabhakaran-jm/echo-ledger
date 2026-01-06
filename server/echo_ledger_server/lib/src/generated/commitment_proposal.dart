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

abstract class CommitmentProposal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CommitmentProposalTable();

  static const db = CommitmentProposalRepository._();

  @override
  int? id;

  int userId;

  String title;

  String category;

  double perceivedWeeklyEffort;

  int perceivedDurationWeeks;

  String effortType;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CommitmentProposalInclude include() {
    return CommitmentProposalInclude._();
  }

  static CommitmentProposalIncludeList includeList({
    _i1.WhereExpressionBuilder<CommitmentProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentProposalTable>? orderByList,
    CommitmentProposalInclude? include,
  }) {
    return CommitmentProposalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommitmentProposal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CommitmentProposal.t),
      include: include,
    );
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

class CommitmentProposalUpdateTable
    extends _i1.UpdateTable<CommitmentProposalTable> {
  CommitmentProposalUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> category(String value) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<double, double> perceivedWeeklyEffort(double value) =>
      _i1.ColumnValue(
        table.perceivedWeeklyEffort,
        value,
      );

  _i1.ColumnValue<int, int> perceivedDurationWeeks(int value) =>
      _i1.ColumnValue(
        table.perceivedDurationWeeks,
        value,
      );

  _i1.ColumnValue<String, String> effortType(String value) => _i1.ColumnValue(
    table.effortType,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class CommitmentProposalTable extends _i1.Table<int?> {
  CommitmentProposalTable({super.tableRelation})
    : super(tableName: 'commitment_proposal') {
    updateTable = CommitmentProposalUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    category = _i1.ColumnString(
      'category',
      this,
    );
    perceivedWeeklyEffort = _i1.ColumnDouble(
      'perceivedWeeklyEffort',
      this,
    );
    perceivedDurationWeeks = _i1.ColumnInt(
      'perceivedDurationWeeks',
      this,
    );
    effortType = _i1.ColumnString(
      'effortType',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final CommitmentProposalUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString category;

  late final _i1.ColumnDouble perceivedWeeklyEffort;

  late final _i1.ColumnInt perceivedDurationWeeks;

  late final _i1.ColumnString effortType;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    category,
    perceivedWeeklyEffort,
    perceivedDurationWeeks,
    effortType,
    createdAt,
  ];
}

class CommitmentProposalInclude extends _i1.IncludeObject {
  CommitmentProposalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CommitmentProposal.t;
}

class CommitmentProposalIncludeList extends _i1.IncludeList {
  CommitmentProposalIncludeList._({
    _i1.WhereExpressionBuilder<CommitmentProposalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CommitmentProposal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CommitmentProposal.t;
}

class CommitmentProposalRepository {
  const CommitmentProposalRepository._();

  /// Returns a list of [CommitmentProposal]s matching the given query parameters.
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
  Future<List<CommitmentProposal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentProposalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentProposalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CommitmentProposal>(
      where: where?.call(CommitmentProposal.t),
      orderBy: orderBy?.call(CommitmentProposal.t),
      orderByList: orderByList?.call(CommitmentProposal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CommitmentProposal] matching the given query parameters.
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
  Future<CommitmentProposal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentProposalTable>? where,
    int? offset,
    _i1.OrderByBuilder<CommitmentProposalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CommitmentProposalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CommitmentProposal>(
      where: where?.call(CommitmentProposal.t),
      orderBy: orderBy?.call(CommitmentProposal.t),
      orderByList: orderByList?.call(CommitmentProposal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CommitmentProposal] by its [id] or null if no such row exists.
  Future<CommitmentProposal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CommitmentProposal>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CommitmentProposal]s in the list and returns the inserted rows.
  ///
  /// The returned [CommitmentProposal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CommitmentProposal>> insert(
    _i1.Session session,
    List<CommitmentProposal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CommitmentProposal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CommitmentProposal] and returns the inserted row.
  ///
  /// The returned [CommitmentProposal] will have its `id` field set.
  Future<CommitmentProposal> insertRow(
    _i1.Session session,
    CommitmentProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CommitmentProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CommitmentProposal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CommitmentProposal>> update(
    _i1.Session session,
    List<CommitmentProposal> rows, {
    _i1.ColumnSelections<CommitmentProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CommitmentProposal>(
      rows,
      columns: columns?.call(CommitmentProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommitmentProposal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CommitmentProposal> updateRow(
    _i1.Session session,
    CommitmentProposal row, {
    _i1.ColumnSelections<CommitmentProposalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CommitmentProposal>(
      row,
      columns: columns?.call(CommitmentProposal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CommitmentProposal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CommitmentProposal?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CommitmentProposalUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CommitmentProposal>(
      id,
      columnValues: columnValues(CommitmentProposal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CommitmentProposal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CommitmentProposal>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CommitmentProposalUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CommitmentProposalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CommitmentProposalTable>? orderBy,
    _i1.OrderByListBuilder<CommitmentProposalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CommitmentProposal>(
      columnValues: columnValues(CommitmentProposal.t.updateTable),
      where: where(CommitmentProposal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CommitmentProposal.t),
      orderByList: orderByList?.call(CommitmentProposal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CommitmentProposal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CommitmentProposal>> delete(
    _i1.Session session,
    List<CommitmentProposal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CommitmentProposal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CommitmentProposal].
  Future<CommitmentProposal> deleteRow(
    _i1.Session session,
    CommitmentProposal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CommitmentProposal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CommitmentProposal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CommitmentProposalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CommitmentProposal>(
      where: where(CommitmentProposal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CommitmentProposalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CommitmentProposal>(
      where: where?.call(CommitmentProposal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
