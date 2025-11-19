/// Base API Exceptions
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  ApiException({required this.message, this.statusCode, this.details});

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, details: $details)';
}

class NoInternetException extends ApiException {
  NoInternetException([String message = "No internet connection"])
    : super(message: message);
}

class TimeoutException extends ApiException {
  TimeoutException([String message = "Request timed out"])
    : super(message: message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String message = "Unauthorized request"])
    // ignore: empty_constructor_bodies
    : super(message: message, statusCode: 401) {}
}

class ForbiddenException extends ApiException {
  ForbiddenException([String message = "Forbidden request"])
    : super(message: message, statusCode: 403);
}

class NotFoundException extends ApiException {
  NotFoundException([String message = "Resource not found"])
    : super(message: message, statusCode: 404);
}

class ServerErrorException extends ApiException {
  ServerErrorException([String message = "Server error occurred"])
    : super(message: message);
}

class ParsingException extends ApiException {
  ParsingException([String message = "Failed to parse response"])
    : super(message: message);
}
