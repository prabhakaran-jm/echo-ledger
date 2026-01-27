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
import 'commitment.dart' as _i2;
import 'commitment_log.dart' as _i3;
import 'commitment_proposal.dart' as _i4;
import 'friction_projection.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'post_commitment_reflection.dart' as _i7;
import 'package:echo_ledger_client/src/utils/rate_limit_data.dart' as _i8;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i10;
export 'commitment.dart';
export 'commitment_log.dart';
export 'commitment_proposal.dart';
export 'friction_projection.dart';
export 'greetings/greeting.dart';
export 'post_commitment_reflection.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Commitment) {
      return _i2.Commitment.fromJson(data) as T;
    }
    if (t == _i3.CommitmentLog) {
      return _i3.CommitmentLog.fromJson(data) as T;
    }
    if (t == _i4.CommitmentProposal) {
      return _i4.CommitmentProposal.fromJson(data) as T;
    }
    if (t == _i5.FrictionProjection) {
      return _i5.FrictionProjection.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.PostCommitmentReflection) {
      return _i7.PostCommitmentReflection.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Commitment?>()) {
      return (data != null ? _i2.Commitment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.CommitmentLog?>()) {
      return (data != null ? _i3.CommitmentLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CommitmentProposal?>()) {
      return (data != null ? _i4.CommitmentProposal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.FrictionProjection?>()) {
      return (data != null ? _i5.FrictionProjection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PostCommitmentReflection?>()) {
      return (data != null ? _i7.PostCommitmentReflection.fromJson(data) : null)
          as T;
    }
    if (t == _i8.RateLimitData) {
      return _i8.RateLimitData.fromJson(data) as T;
    }
    if (t == _i1.getType<_i8.RateLimitData?>()) {
      return (data != null ? _i8.RateLimitData.fromJson(data) : null) as T;
    }
    try {
      return _i9.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i8.RateLimitData => 'RateLimitData',
      _i2.Commitment => 'Commitment',
      _i3.CommitmentLog => 'CommitmentLog',
      _i4.CommitmentProposal => 'CommitmentProposal',
      _i5.FrictionProjection => 'FrictionProjection',
      _i6.Greeting => 'Greeting',
      _i7.PostCommitmentReflection => 'PostCommitmentReflection',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('echo_ledger.', '');
    }

    switch (data) {
      case _i8.RateLimitData():
        return 'RateLimitData';
      case _i2.Commitment():
        return 'Commitment';
      case _i3.CommitmentLog():
        return 'CommitmentLog';
      case _i4.CommitmentProposal():
        return 'CommitmentProposal';
      case _i5.FrictionProjection():
        return 'FrictionProjection';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.PostCommitmentReflection():
        return 'PostCommitmentReflection';
    }
    className = _i9.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i10.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'RateLimitData') {
      return deserialize<_i8.RateLimitData>(data['data']);
    }
    if (dataClassName == 'Commitment') {
      return deserialize<_i2.Commitment>(data['data']);
    }
    if (dataClassName == 'CommitmentLog') {
      return deserialize<_i3.CommitmentLog>(data['data']);
    }
    if (dataClassName == 'CommitmentProposal') {
      return deserialize<_i4.CommitmentProposal>(data['data']);
    }
    if (dataClassName == 'FrictionProjection') {
      return deserialize<_i5.FrictionProjection>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'PostCommitmentReflection') {
      return deserialize<_i7.PostCommitmentReflection>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i9.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i10.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i9.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i10.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
