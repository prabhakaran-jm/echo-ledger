import 'package:serverpod_client/serverpod_client.dart';

/// Client-side mirror of server RateLimitData for protocol serialization.
/// Used by generated protocol when deserializing cache entries.
class RateLimitData implements SerializableModel {
  final int count;
  final int windowStart;

  RateLimitData({
    required this.count,
    required this.windowStart,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'windowStart': windowStart,
    };
  }

  factory RateLimitData.fromJson(Map<String, dynamic> json) {
    return RateLimitData(
      count: json['count'] as int,
      windowStart: json['windowStart'] as int,
    );
  }

  RateLimitData copyWith({int? count, int? windowStart}) {
    return RateLimitData(
      count: count ?? this.count,
      windowStart: windowStart ?? this.windowStart,
    );
  }
}
