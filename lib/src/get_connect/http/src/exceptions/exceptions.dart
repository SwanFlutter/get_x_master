import 'dart:convert';

/// Base exception class for all GetConnect HTTP exceptions.
/// Provides detailed error information including URI, status code, and response body.
class GetHttpException implements Exception {
  final String message;
  final Uri? uri;
  final int? statusCode;
  final dynamic responseBody;
  final Map<String, String>? headers;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  GetHttpException(
    this.message, {
    this.uri,
    this.statusCode,
    this.responseBody,
    this.headers,
    this.stackTrace,
  }) : timestamp = DateTime.now();

  /// Check if this is a client error (4xx)
  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! < 500;

  /// Check if this is a server error (5xx)
  bool get isServerError =>
      statusCode != null && statusCode! >= 500 && statusCode! < 600;

  /// Check if this is a network/connection error
  bool get isNetworkError => statusCode == null;

  @override
  String toString() {
    final buffer = StringBuffer('GetHttpException: $message');
    if (statusCode != null) buffer.write(' [Status: $statusCode]');
    if (uri != null) buffer.write(' [URI: $uri]');
    return buffer.toString();
  }

  /// Returns a detailed error report for debugging
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln('GetConnect Error Report');
    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln('Message: $message');
    buffer.writeln('Timestamp: $timestamp');
    if (statusCode != null) buffer.writeln('Status Code: $statusCode');
    if (uri != null) buffer.writeln('URI: $uri');
    if (headers != null && headers!.isNotEmpty) {
      buffer.writeln('Headers: ${jsonEncode(headers)}');
    }
    if (responseBody != null) {
      buffer.writeln('Response Body: $responseBody');
    }
    if (stackTrace != null) {
      buffer.writeln('Stack Trace:');
      buffer.writeln(stackTrace);
    }
    buffer.writeln('═══════════════════════════════════════');
    return buffer.toString();
  }

  /// Convert exception to Map for logging or serialization
  Map<String, dynamic> toMap() => {
    'type': runtimeType.toString(),
    'message': message,
    'statusCode': statusCode,
    'uri': uri?.toString(),
    'timestamp': timestamp.toIso8601String(),
    'responseBody': responseBody?.toString(),
  };
}

/// Exception thrown when a request times out.
class TimeoutException extends GetHttpException {
  final Duration? duration;

  TimeoutException(super.message, {super.uri, this.duration, super.stackTrace});

  @override
  String toString() {
    final durationStr = duration != null
        ? ' after ${duration!.inSeconds}s'
        : '';
    return 'TimeoutException: $message$durationStr${uri != null ? ' [URI: $uri]' : ''}';
  }
}

/// Exception thrown when there's a network connectivity issue.
class NetworkException extends GetHttpException {
  final NetworkErrorType errorType;

  NetworkException(
    super.message, {
    super.uri,
    this.errorType = NetworkErrorType.unknown,
    super.stackTrace,
  });

  @override
  String toString() =>
      'NetworkException: $message [Type: ${errorType.name}]${uri != null ? ' [URI: $uri]' : ''}';
}

/// Types of network errors
enum NetworkErrorType {
  noInternet,
  dnsLookupFailed,
  connectionRefused,
  connectionReset,
  sslHandshakeFailed,
  unknown,
}

/// Exception thrown for 400 Bad Request errors.
class BadRequestException extends GetHttpException {
  final Map<String, dynamic>? validationErrors;

  BadRequestException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    this.validationErrors,
    super.stackTrace,
  }) : super(statusCode: 400);

  @override
  String toString() =>
      'BadRequestException: $message${uri != null ? ' [URI: $uri]' : ''}';
}

/// Exception thrown for 401 Unauthorized errors.
class UnauthorizedException extends GetHttpException {
  final String? authScheme;

  UnauthorizedException({
    String message = 'Operation Unauthorized',
    super.uri,
    super.responseBody,
    super.headers,
    this.authScheme,
    super.stackTrace,
  }) : super(message, statusCode: 401);

  @override
  String toString() =>
      'UnauthorizedException: $message${authScheme != null ? ' [Scheme: $authScheme]' : ''}';
}

/// Exception thrown for 403 Forbidden errors.
class ForbiddenException extends GetHttpException {
  ForbiddenException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 403);

  @override
  String toString() =>
      'ForbiddenException: $message${uri != null ? ' [URI: $uri]' : ''}';
}

/// Exception thrown for 404 Not Found errors.
class NotFoundException extends GetHttpException {
  NotFoundException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 404);

  @override
  String toString() =>
      'NotFoundException: $message${uri != null ? ' [URI: $uri]' : ''}';
}

/// Exception thrown for 405 Method Not Allowed errors.
class MethodNotAllowedException extends GetHttpException {
  final List<String>? allowedMethods;

  MethodNotAllowedException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    this.allowedMethods,
    super.stackTrace,
  }) : super(statusCode: 405);

  @override
  String toString() {
    final allowed = allowedMethods != null
        ? ' [Allowed: ${allowedMethods!.join(', ')}]'
        : '';
    return 'MethodNotAllowedException: $message$allowed';
  }
}

/// Exception thrown for 408 Request Timeout errors.
class RequestTimeoutException extends GetHttpException {
  RequestTimeoutException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 408);
}

/// Exception thrown for 409 Conflict errors.
class ConflictException extends GetHttpException {
  ConflictException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 409);
}

/// Exception thrown for 422 Unprocessable Entity errors.
class UnprocessableEntityException extends GetHttpException {
  final Map<String, List<String>>? fieldErrors;

  UnprocessableEntityException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    this.fieldErrors,
    super.stackTrace,
  }) : super(statusCode: 422);

  @override
  String toString() {
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      return 'UnprocessableEntityException: $message\nField Errors: $fieldErrors';
    }
    return 'UnprocessableEntityException: $message';
  }
}

/// Exception thrown for 429 Too Many Requests errors.
class TooManyRequestsException extends GetHttpException {
  final Duration? retryAfter;

  TooManyRequestsException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    this.retryAfter,
    super.stackTrace,
  }) : super(statusCode: 429);

  @override
  String toString() {
    final retry = retryAfter != null
        ? ' [Retry after: ${retryAfter!.inSeconds}s]'
        : '';
    return 'TooManyRequestsException: $message$retry';
  }
}

/// Exception thrown for 500 Internal Server Error.
class InternalServerException extends GetHttpException {
  InternalServerException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 500);
}

/// Exception thrown for 502 Bad Gateway errors.
class BadGatewayException extends GetHttpException {
  BadGatewayException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 502);
}

/// Exception thrown for 503 Service Unavailable errors.
class ServiceUnavailableException extends GetHttpException {
  final Duration? retryAfter;

  ServiceUnavailableException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    this.retryAfter,
    super.stackTrace,
  }) : super(statusCode: 503);

  @override
  String toString() {
    final retry = retryAfter != null
        ? ' [Retry after: ${retryAfter!.inSeconds}s]'
        : '';
    return 'ServiceUnavailableException: $message$retry';
  }
}

/// Exception thrown for 504 Gateway Timeout errors.
class GatewayTimeoutException extends GetHttpException {
  GatewayTimeoutException(
    super.message, {
    super.uri,
    super.responseBody,
    super.headers,
    super.stackTrace,
  }) : super(statusCode: 504);
}

/// Exception thrown when response format is unexpected.
class UnexpectedFormat extends GetHttpException {
  final String? expectedFormat;
  final String? actualFormat;

  UnexpectedFormat(
    super.message, {
    super.uri,
    super.responseBody,
    this.expectedFormat,
    this.actualFormat,
    super.stackTrace,
  });

  @override
  String toString() {
    final buffer = StringBuffer('UnexpectedFormat: $message');
    if (expectedFormat != null) buffer.write(' [Expected: $expectedFormat]');
    if (actualFormat != null) buffer.write(' [Actual: $actualFormat]');
    return buffer.toString();
  }
}

/// Exception thrown when request is cancelled/aborted.
class RequestCancelledException extends GetHttpException {
  RequestCancelledException(super.message, {super.uri, super.stackTrace});

  @override
  String toString() =>
      'RequestCancelledException: $message${uri != null ? ' [URI: $uri]' : ''}';
}

/// GraphQL specific error
class GraphQLError {
  final String? message;
  final String? code;
  final List<dynamic>? path;
  final Map<String, dynamic>? extensions;
  final List<GraphQLErrorLocation>? locations;

  GraphQLError({
    this.code,
    this.message,
    this.path,
    this.extensions,
    this.locations,
  });

  factory GraphQLError.fromJson(Map<String, dynamic> json) {
    return GraphQLError(
      message: json['message']?.toString(),
      code: json['extensions']?['code']?.toString(),
      path: json['path'] as List<dynamic>?,
      extensions: json['extensions'] as Map<String, dynamic>?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((loc) => GraphQLErrorLocation.fromJson(loc))
          .toList(),
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer('GraphQLError:');
    if (code != null) buffer.write('\n  Code: $code');
    if (message != null) buffer.write('\n  Message: $message');
    if (path != null) buffer.write('\n  Path: ${path!.join(' -> ')}');
    if (locations != null && locations!.isNotEmpty) {
      buffer.write(
        '\n  Locations: ${locations!.map((l) => l.toString()).join(', ')}',
      );
    }
    return buffer.toString();
  }

  Map<String, dynamic> toMap() => {
    'code': code,
    'message': message,
    'path': path,
    'extensions': extensions,
    'locations': locations?.map((l) => l.toMap()).toList(),
  };
}

/// GraphQL error location
class GraphQLErrorLocation {
  final int? line;
  final int? column;

  GraphQLErrorLocation({this.line, this.column});

  factory GraphQLErrorLocation.fromJson(Map<String, dynamic> json) {
    return GraphQLErrorLocation(
      line: json['line'] as int?,
      column: json['column'] as int?,
    );
  }

  @override
  String toString() => 'Line $line, Column $column';

  Map<String, dynamic> toMap() => {'line': line, 'column': column};
}
