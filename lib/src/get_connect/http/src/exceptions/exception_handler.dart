import 'dart:async' as async_lib show TimeoutException;
import 'dart:io';

import '../response/response.dart';
import 'exceptions.dart';
import 'result.dart';

/// Handles HTTP exceptions and converts responses to appropriate exception types.
class ExceptionHandler {
  /// Converts a Response to the appropriate GetHttpException based on status code.
  static GetHttpException fromResponse<T>(Response<T> response) {
    final statusCode = response.statusCode;
    final uri = response.request?.url;
    final body = response.body;
    final headers = response.headers;
    final message = response.statusText ?? 'Unknown error';

    return switch (statusCode) {
      400 => BadRequestException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      401 => UnauthorizedException(
        message: message,
        uri: uri,
        responseBody: body,
        headers: headers,
        authScheme: _extractAuthScheme(headers),
      ),
      403 => ForbiddenException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      404 => NotFoundException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      405 => MethodNotAllowedException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
        allowedMethods: _extractAllowedMethods(headers),
      ),
      408 => RequestTimeoutException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      409 => ConflictException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      422 => UnprocessableEntityException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      429 => TooManyRequestsException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
        retryAfter: _extractRetryAfter(headers),
      ),
      500 => InternalServerException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      502 => BadGatewayException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      503 => ServiceUnavailableException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
        retryAfter: _extractRetryAfter(headers),
      ),
      504 => GatewayTimeoutException(
        message,
        uri: uri,
        responseBody: body,
        headers: headers,
      ),
      _ => GetHttpException(
        message,
        uri: uri,
        statusCode: statusCode,
        responseBody: body,
        headers: headers,
      ),
    };
  }

  /// Converts a caught exception to a GetHttpException.
  static GetHttpException fromException(
    Object error, {
    Uri? uri,
    StackTrace? stackTrace,
  }) {
    if (error is GetHttpException) {
      return error;
    }

    if (error is SocketException) {
      return NetworkException(
        'Network connection failed: ${error.message}',
        uri: uri,
        errorType: _classifySocketException(error),
        stackTrace: stackTrace,
      );
    }

    if (error is async_lib.TimeoutException) {
      final timeoutError = error;
      return TimeoutException(
        'Request timed out: ${timeoutError.message ?? 'No response received'}',
        uri: uri,
        duration: timeoutError.duration,
        stackTrace: stackTrace,
      );
    }

    if (error is HandshakeException) {
      return NetworkException(
        'SSL/TLS handshake failed: ${error.message}',
        uri: uri,
        errorType: NetworkErrorType.sslHandshakeFailed,
        stackTrace: stackTrace,
      );
    }

    if (error is CertificateException) {
      return NetworkException(
        'Certificate verification failed: ${error.message}',
        uri: uri,
        errorType: NetworkErrorType.sslHandshakeFailed,
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException) {
      return UnexpectedFormat(
        'Invalid response format: ${error.message}',
        uri: uri,
        stackTrace: stackTrace,
      );
    }

    return GetHttpException(error.toString(), uri: uri, stackTrace: stackTrace);
  }

  /// Classifies a SocketException into a NetworkErrorType.
  static NetworkErrorType _classifySocketException(SocketException error) {
    final message = error.message.toLowerCase();
    final osErrorMessage = error.osError?.message;
    final osError = osErrorMessage?.toLowerCase() ?? '';

    if (message.contains('no route to host') ||
        message.contains('network is unreachable') ||
        osError.contains('no internet')) {
      return NetworkErrorType.noInternet;
    }

    if (message.contains('failed host lookup') ||
        message.contains('getaddrinfo') ||
        osError.contains('name or service not known')) {
      return NetworkErrorType.dnsLookupFailed;
    }

    if (message.contains('connection refused') ||
        osError.contains('connection refused')) {
      return NetworkErrorType.connectionRefused;
    }

    if (message.contains('connection reset') ||
        osError.contains('connection reset')) {
      return NetworkErrorType.connectionReset;
    }

    return NetworkErrorType.unknown;
  }

  /// Extracts the authentication scheme from headers.
  static String? _extractAuthScheme(Map<String, String>? headers) {
    final wwwAuth = headers?['www-authenticate'];
    if (wwwAuth == null) return null;

    final match = RegExp(r'^(\w+)').firstMatch(wwwAuth);
    return match?.group(1);
  }

  /// Extracts allowed methods from the Allow header.
  static List<String>? _extractAllowedMethods(Map<String, String>? headers) {
    final allow = headers?['allow'];
    if (allow == null) return null;

    return allow.split(',').map((m) => m.trim().toUpperCase()).toList();
  }

  /// Extracts retry-after duration from headers.
  static Duration? _extractRetryAfter(Map<String, String>? headers) {
    final retryAfter = headers?['retry-after'];
    if (retryAfter == null) return null;

    // Try parsing as seconds
    final seconds = int.tryParse(retryAfter);
    if (seconds != null) {
      return Duration(seconds: seconds);
    }

    // Try parsing as HTTP date
    try {
      final date = HttpDate.parse(retryAfter);
      return date.difference(DateTime.now());
    } catch (_) {
      return null;
    }
  }

  /// Wraps an async operation and converts exceptions to Result.
  static Future<Result<T>> guard<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Result.success(result);
    } on GetHttpException catch (e) {
      return Result.failure(e);
    } catch (e, stackTrace) {
      return Result.failure(fromException(e, stackTrace: stackTrace));
    }
  }

  /// Wraps an async operation with retry logic.
  static Future<T> withRetry<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
    bool Function(Object error)? shouldRetry,
  }) async {
    int attempts = 0;
    Duration delay = initialDelay;

    while (true) {
      try {
        return await operation();
      } catch (e) {
        attempts++;

        final shouldRetryError = shouldRetry?.call(e) ?? _defaultShouldRetry(e);

        if (attempts >= maxRetries || !shouldRetryError) {
          rethrow;
        }

        await Future.delayed(delay);
        delay = Duration(
          milliseconds: (delay.inMilliseconds * backoffMultiplier).round(),
        );
      }
    }
  }

  /// Default retry logic - retry on network and server errors.
  static bool _defaultShouldRetry(Object error) {
    if (error is NetworkException) return true;
    if (error is TimeoutException) return true;
    if (error is GetHttpException) {
      return error.isServerError;
    }
    return false;
  }
}

/// Extension to easily convert Response to Result.
extension ResponseToResult<T> on Response<T> {
  /// Converts this Response to a Result.
  /// Returns Success if the response is OK, otherwise returns Failure.
  Result<T> toResult() {
    if (isOk && body != null) {
      return Result.success(body as T);
    }
    return Result.failure(ExceptionHandler.fromResponse(this));
  }

  /// Throws an appropriate exception if the response has an error.
  Response<T> throwIfError() {
    if (hasError) {
      throw ExceptionHandler.fromResponse(this);
    }
    return this;
  }
}

/// Extension for [Future] of [Response] to easily handle errors.
extension FutureResponseExtension<T> on Future<Response<T>> {
  /// Converts the Future Response to Future Result.
  Future<Result<T>> toResult() async {
    try {
      final response = await this;
      return response.toResult();
    } catch (e, stackTrace) {
      return Result.failure(
        ExceptionHandler.fromException(e, stackTrace: stackTrace),
      );
    }
  }

  /// Throws an appropriate exception if the response has an error.
  Future<Response<T>> throwIfError() async {
    final response = await this;
    return response.throwIfError();
  }
}
