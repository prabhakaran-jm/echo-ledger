import 'package:serverpod/serverpod.dart';

/// Data model for rate limiting cache entries.
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
}

