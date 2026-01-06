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

abstract class PostCommitmentReflection
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = PostCommitmentReflectionTable();

  static const db = PostCommitmentReflectionRepository._();

  @override
  int? id;

  int commitmentId;

  int regretScore;

  int satisfactionScore;

  String wouldRepeat;

  String? notes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static PostCommitmentReflectionInclude include() {
    return PostCommitmentReflectionInclude._();
  }

  static PostCommitmentReflectionIncludeList includeList({
    _i1.WhereExpressionBuilder<PostCommitmentReflectionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostCommitmentReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostCommitmentReflectionTable>? orderByList,
    PostCommitmentReflectionInclude? include,
  }) {
    return PostCommitmentReflectionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostCommitmentReflection.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PostCommitmentReflection.t),
      include: include,
    );
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

class PostCommitmentReflectionUpdateTable
    extends _i1.UpdateTable<PostCommitmentReflectionTable> {
  PostCommitmentReflectionUpdateTable(super.table);

  _i1.ColumnValue<int, int> commitmentId(int value) => _i1.ColumnValue(
    table.commitmentId,
    value,
  );

  _i1.ColumnValue<int, int> regretScore(int value) => _i1.ColumnValue(
    table.regretScore,
    value,
  );

  _i1.ColumnValue<int, int> satisfactionScore(int value) => _i1.ColumnValue(
    table.satisfactionScore,
    value,
  );

  _i1.ColumnValue<String, String> wouldRepeat(String value) => _i1.ColumnValue(
    table.wouldRepeat,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PostCommitmentReflectionTable extends _i1.Table<int?> {
  PostCommitmentReflectionTable({super.tableRelation})
    : super(tableName: 'post_commitment_reflection') {
    updateTable = PostCommitmentReflectionUpdateTable(this);
    commitmentId = _i1.ColumnInt(
      'commitmentId',
      this,
    );
    regretScore = _i1.ColumnInt(
      'regretScore',
      this,
    );
    satisfactionScore = _i1.ColumnInt(
      'satisfactionScore',
      this,
    );
    wouldRepeat = _i1.ColumnString(
      'wouldRepeat',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PostCommitmentReflectionUpdateTable updateTable;

  late final _i1.ColumnInt commitmentId;

  late final _i1.ColumnInt regretScore;

  late final _i1.ColumnInt satisfactionScore;

  late final _i1.ColumnString wouldRepeat;

  late final _i1.ColumnString notes;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    commitmentId,
    regretScore,
    satisfactionScore,
    wouldRepeat,
    notes,
    createdAt,
  ];
}

class PostCommitmentReflectionInclude extends _i1.IncludeObject {
  PostCommitmentReflectionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PostCommitmentReflection.t;
}

class PostCommitmentReflectionIncludeList extends _i1.IncludeList {
  PostCommitmentReflectionIncludeList._({
    _i1.WhereExpressionBuilder<PostCommitmentReflectionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PostCommitmentReflection.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PostCommitmentReflection.t;
}

class PostCommitmentReflectionRepository {
  const PostCommitmentReflectionRepository._();

  /// Returns a list of [PostCommitmentReflection]s matching the given query parameters.
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
  Future<List<PostCommitmentReflection>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PostCommitmentReflectionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostCommitmentReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostCommitmentReflectionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PostCommitmentReflection>(
      where: where?.call(PostCommitmentReflection.t),
      orderBy: orderBy?.call(PostCommitmentReflection.t),
      orderByList: orderByList?.call(PostCommitmentReflection.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PostCommitmentReflection] matching the given query parameters.
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
  Future<PostCommitmentReflection?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PostCommitmentReflectionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PostCommitmentReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostCommitmentReflectionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PostCommitmentReflection>(
      where: where?.call(PostCommitmentReflection.t),
      orderBy: orderBy?.call(PostCommitmentReflection.t),
      orderByList: orderByList?.call(PostCommitmentReflection.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PostCommitmentReflection] by its [id] or null if no such row exists.
  Future<PostCommitmentReflection?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PostCommitmentReflection>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PostCommitmentReflection]s in the list and returns the inserted rows.
  ///
  /// The returned [PostCommitmentReflection]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PostCommitmentReflection>> insert(
    _i1.Session session,
    List<PostCommitmentReflection> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PostCommitmentReflection>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PostCommitmentReflection] and returns the inserted row.
  ///
  /// The returned [PostCommitmentReflection] will have its `id` field set.
  Future<PostCommitmentReflection> insertRow(
    _i1.Session session,
    PostCommitmentReflection row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PostCommitmentReflection>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PostCommitmentReflection]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PostCommitmentReflection>> update(
    _i1.Session session,
    List<PostCommitmentReflection> rows, {
    _i1.ColumnSelections<PostCommitmentReflectionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PostCommitmentReflection>(
      rows,
      columns: columns?.call(PostCommitmentReflection.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostCommitmentReflection]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PostCommitmentReflection> updateRow(
    _i1.Session session,
    PostCommitmentReflection row, {
    _i1.ColumnSelections<PostCommitmentReflectionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PostCommitmentReflection>(
      row,
      columns: columns?.call(PostCommitmentReflection.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostCommitmentReflection] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PostCommitmentReflection?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PostCommitmentReflectionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PostCommitmentReflection>(
      id,
      columnValues: columnValues(PostCommitmentReflection.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PostCommitmentReflection]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PostCommitmentReflection>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PostCommitmentReflectionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PostCommitmentReflectionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostCommitmentReflectionTable>? orderBy,
    _i1.OrderByListBuilder<PostCommitmentReflectionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PostCommitmentReflection>(
      columnValues: columnValues(PostCommitmentReflection.t.updateTable),
      where: where(PostCommitmentReflection.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostCommitmentReflection.t),
      orderByList: orderByList?.call(PostCommitmentReflection.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PostCommitmentReflection]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PostCommitmentReflection>> delete(
    _i1.Session session,
    List<PostCommitmentReflection> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PostCommitmentReflection>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PostCommitmentReflection].
  Future<PostCommitmentReflection> deleteRow(
    _i1.Session session,
    PostCommitmentReflection row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PostCommitmentReflection>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PostCommitmentReflection>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PostCommitmentReflectionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PostCommitmentReflection>(
      where: where(PostCommitmentReflection.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PostCommitmentReflectionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PostCommitmentReflection>(
      where: where?.call(PostCommitmentReflection.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
