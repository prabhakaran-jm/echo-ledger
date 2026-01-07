/// Base exception for application-specific errors.
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Thrown when authentication is required but not provided.
class AuthenticationRequiredException extends AppException {
  const AuthenticationRequiredException([String? message])
      : super(message ?? 'Authentication required', statusCode: 401);
}

/// Thrown when a user attempts to access resources belonging to another user.
class UnauthorizedAccessException extends AppException {
  const UnauthorizedAccessException([String? message])
      : super(message ?? 'Unauthorized access', statusCode: 403);
}

/// Thrown when input validation fails.
class ValidationException extends AppException {
  const ValidationException(String message) : super(message, statusCode: 400);
}

/// Thrown when a requested resource is not found.
class NotFoundException extends AppException {
  const NotFoundException([String? message])
      : super(message ?? 'Resource not found', statusCode: 404);
}

/// Thrown when an operation is not allowed in the current environment.
class OperationNotAllowedException extends AppException {
  const OperationNotAllowedException([String? message])
      : super(message ?? 'Operation not allowed', statusCode: 403);
}

