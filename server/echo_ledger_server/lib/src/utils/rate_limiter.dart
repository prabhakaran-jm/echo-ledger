import 'package:serverpod/serverpod.dart';

import 'rate_limit_data.dart';

/// Simple rate limiter using Serverpod's cache.
///
/// Tracks request counts per key (e.g., userId or IP address) within a time window.
class RateLimiter {
  /// Checks if a request should be allowed based on rate limiting rules.
  ///
  /// - [session]: The Serverpod session for cache access
  /// - [key]: Unique identifier for rate limiting (e.g., userId, IP address)
  /// - [maxRequests]: Maximum number of requests allowed in the time window
  /// - [windowSeconds]: Time window in seconds
  ///
  /// Returns `true` if the request should be allowed, `false` if rate limit exceeded.
  ///
  /// Throws [ValidationException] if rate limit is exceeded.
  static Future<bool> checkRateLimit(
    Session session,
    String key,
    int maxRequests,
    int windowSeconds,
  ) async {
    final cacheKey = 'rate_limit_$key';
    final now = DateTime.now().millisecondsSinceEpoch;

    // Get current request count and timestamp from cache
    final cached = await session.caches.local.get<RateLimitData>(cacheKey);
    
    int requestCount = 0;
    int windowStart = now;

    if (cached != null) {
      requestCount = cached.count;
      windowStart = cached.windowStart;
    }

    // Check if we're still in the same time window
    final elapsedSeconds = (now - windowStart) ~/ 1000;
    
    if (elapsedSeconds >= windowSeconds) {
      // Time window expired, reset counter
      requestCount = 1;
      windowStart = now;
    } else {
      // Still in the same window, increment counter
      requestCount++;
    }

    // Check if rate limit exceeded
    if (requestCount > maxRequests) {
      session.log(
        'Rate limit exceeded: key=$key, count=$requestCount, max=$maxRequests, window=${windowSeconds}s',
        level: LogLevel.warning,
      );
      return false;
    }

    // Update cache with new count and window start
    await session.caches.local.put(
      cacheKey,
      RateLimitData(
        count: requestCount,
        windowStart: windowStart,
      ),
      lifetime: Duration(seconds: windowSeconds),
    );

    return true;
  }

  /// Gets the current request count for a given key.
  ///
  /// Useful for debugging or returning rate limit information to clients.
  static Future<int> getRequestCount(
    Session session,
    String key,
  ) async {
    final cacheKey = 'rate_limit_$key';
    final cached = await session.caches.local.get<RateLimitData>(cacheKey);
    
    if (cached == null) {
      return 0;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsedSeconds = (now - cached.windowStart) ~/ 1000;

    // If window expired, return 0
    if (elapsedSeconds >= 60) {
      return 0;
    }

    return cached.count;
  }
}

