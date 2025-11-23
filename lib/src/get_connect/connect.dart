// ignore_for_file: unused_element

import 'package:flutter/widgets.dart';

import '../get_instance/src/lifecycle.dart';
import 'http/src/certificates/certificates.dart';
import 'http/src/exceptions/exceptions.dart';
import 'http/src/http.dart';
import 'http/src/response/response.dart';
import 'sockets/sockets.dart';

export 'http/src/certificates/certificates.dart';
export 'http/src/http.dart';
export 'http/src/multipart/form_data.dart';
export 'http/src/multipart/multipart_file.dart';
export 'http/src/response/response.dart';
export 'sockets/sockets.dart';

/// Cached response data for HTTP caching
class CachedResponse<T> {
  final Response<T> response;
  final DateTime cachedAt;
  final Duration maxAge;

  CachedResponse({
    required this.response,
    required this.cachedAt,
    required this.maxAge,
  });

  bool get isExpired => DateTime.now().difference(cachedAt) > maxAge;
}

abstract class GetConnectInterface with GetLifeCycleBase {
  List<GetSocket>? sockets;
  GetHttpClient get httpClient;

  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  });

  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  });

  Future<Response<T>> post<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  });

  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  });

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  });

  Future<Response<T>> patch<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  });

  Future<GraphQLResponse<T>> query<T>(
    String query, {
    String? url,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  });

  Future<GraphQLResponse<T>> mutation<T>(
    String mutation, {
    String? url,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  });

  GetSocket socket(String url, {Duration ping = const Duration(seconds: 5)});
}

class GetConnect extends GetConnectInterface {
  GetConnect({
    this.userAgent = 'getx-client',
    this.timeout = const Duration(seconds: 5),
    this.followRedirects = true,
    this.maxRedirects = 5,
    this.sendUserAgent = false,
    this.maxAuthRetries = 1,
    this.allowAutoSignedCert = false,
    this.withCredentials = false,
  });

  bool allowAutoSignedCert;
  String userAgent;
  bool sendUserAgent;
  String? baseUrl;
  String defaultContentType = 'application/json; charset=utf-8';
  bool followRedirects;
  int maxRedirects;
  int maxAuthRetries;
  Decoder? defaultDecoder;
  Duration timeout;
  List<TrustedCertificate>? trustedCertificates;
  String Function(Uri url)? findProxy;
  GetHttpClient? _httpClient;
  List<GetSocket>? _sockets;
  bool withCredentials;

  // Enhanced features
  bool enableCaching = false;
  Duration cacheMaxAge = const Duration(minutes: 5);
  final Map<String, CachedResponse> _cache = {};
  bool enableRetry = true;
  int maxRetries = 3;
  Duration retryDelay = const Duration(seconds: 1);
  bool enableLogging = false;

  @override
  List<GetSocket> get sockets => _sockets ??= <GetSocket>[];

  @override
  GetHttpClient get httpClient => _httpClient ??= GetHttpClient(
    userAgent: userAgent,
    sendUserAgent: sendUserAgent,
    timeout: timeout,
    followRedirects: followRedirects,
    maxRedirects: maxRedirects,
    maxAuthRetries: maxAuthRetries,
    allowAutoSignedCert: allowAutoSignedCert,
    baseUrl: baseUrl,
    trustedCertificates: trustedCertificates,
    withCredentials: withCredentials,
    findProxy: findProxy,
  );

  /// Performs a GET request to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL (e.g., '/api/users')
  /// - [headers]: Optional HTTP headers (e.g., {'Authorization': 'Bearer token'})
  /// - [contentType]: Optional content type (e.g., 'application/json')
  /// - [query]: Optional query parameters (e.g., {'page': '1', 'limit': '10'})
  /// - [decoder]: Optional custom response decoder
  ///
  /// Example:
  /// ```dart
  /// final response = await client.get<UserModel>(
  ///   '/api/users',
  ///   headers: {'Authorization': 'Bearer $token'},
  ///   query: {'page': '1', 'limit': '10'},
  ///   decoder: (json) => UserModel.fromJson(json),
  /// );
  /// ```
  @override
  Future<Response<T>> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();
    return httpClient.get<T>(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }

  /// Performs a POST request to create or submit data to the specified URL.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL
  /// - [body]: Request payload (can be Map, List, or custom object)
  /// - [contentType]: Optional content type
  /// - [headers]: Optional HTTP headers
  /// - [query]: Optional query parameters
  /// - [decoder]: Optional custom response decoder
  /// - [uploadProgress]: Optional callback for upload progress
  ///
  /// Example:
  /// ```dart
  /// final response = await client.post<LoginResponse>(
  ///   '/api/login',
  ///   body: {
  ///     'email': 'user@example.com',
  ///     'password': '123456'
  ///   },
  ///   decoder: (json) => LoginResponse.fromJson(json),
  /// );
  /// ```
  @override
  Future<Response<T>> post<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();
    return httpClient.post<T>(
      url,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  /// Performs a PUT request to update an entire resource at the specified URL.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL
  /// - [body]: Updated resource data
  /// - Other parameters similar to POST
  ///
  /// Example:
  /// ```dart
  /// final response = await client.put<UserModel>(
  ///   '/api/users/123',
  ///   body: {
  ///     'name': 'John Doe',
  ///     'email': 'john@example.com'
  ///   },
  ///   decoder: (json) => UserModel.fromJson(json),
  /// );
  /// ```
  @override
  Future<Response<T>> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();
    return httpClient.put<T>(
      url,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  /// Performs a PATCH request to partially update a resource.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL
  /// - [body]: Partial update data
  /// - Other parameters similar to POST
  ///
  /// Example:
  /// ```dart
  /// final response = await client.patch<UserModel>(
  ///   '/api/users/123',
  ///   body: {
  ///     'name': 'John Doe' // Only update name
  ///   },
  ///   decoder: (json) => UserModel.fromJson(json),
  /// );
  /// ```
  @override
  Future<Response<T>> patch<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();
    return httpClient.patch<T>(
      url,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  /// Performs a custom HTTP request with the specified method.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL
  /// - [method]: HTTP method (e.g., 'GET', 'POST', etc.)
  /// - Other parameters similar to POST
  ///
  /// Example:
  /// ```dart
  /// final response = await client.request<CustomModel>(
  ///   '/api/custom-endpoint',
  ///   'CUSTOM_METHOD',
  ///   body: {'data': 'value'},
  ///   decoder: (json) => CustomModel.fromJson(json),
  /// );
  /// ```
  @override
  Future<Response<T>> request<T>(
    String url,
    String method, {
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    _checkIfDisposed();
    return httpClient.request<T>(
      url,
      method,
      body: body,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  /// Performs a DELETE request to remove a resource.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL
  /// - [headers]: Optional HTTP headers
  /// - [contentType]: Optional content type
  /// - [query]: Optional query parameters
  /// - [decoder]: Optional custom response decoder
  ///
  /// Example:
  /// ```dart
  /// final response = await client.delete<bool>(
  ///   '/api/users/123',
  ///   headers: {'Authorization': 'Bearer $token'},
  /// );
  /// ```
  @override
  Future<Response<T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    _checkIfDisposed();
    return httpClient.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }

  @override
  GetSocket socket(String url, {Duration ping = const Duration(seconds: 5)}) {
    _checkIfDisposed(isHttp: false);

    final newSocket = GetSocket(_concatUrl(url)!, ping: ping);
    sockets.add(newSocket);
    return newSocket;
  }

  String? _concatUrl(String? url) {
    if (url == null) return baseUrl;
    return baseUrl == null ? url : baseUrl! + url;
  }

  /// query allow made GraphQL raw queries
  /// final connect = GetConnect();
  /// connect.baseUrl = 'https://countries.trevorblades.com/';
  /// final response = await connect.query(
  /// r"""
  /// {
  ///  country(code: "BR") {
  ///    name
  ///    native
  ///    currency
  ///    languages {
  ///      code
  ///      name
  ///    }
  ///  }
  ///}
  ///""",
  ///);
  ///print(response.body);
  @override
  Future<GraphQLResponse<T>> query<T>(
    String query, {
    String? url,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    try {
      final res = await post(url, {
        'query': query,
        'variables': variables,
      }, headers: headers);

      final listError = res.body['errors'];
      if ((listError is List) && listError.isNotEmpty) {
        return GraphQLResponse<T>(
          graphQLErrors: listError
              .map(
                (e) => GraphQLError(
                  code:
                      (e['extensions'] != null
                              ? e['extensions']['code'] ?? ''
                              : '')
                          .toString(),
                  message: (e['message'] ?? '').toString(),
                ),
              )
              .toList(),
        );
      }
      return GraphQLResponse<T>.fromResponse(res);
    } on Exception catch (err) {
      return GraphQLResponse<T>(
        graphQLErrors: [GraphQLError(code: null, message: err.toString())],
      );
    }
  }

  @override
  Future<GraphQLResponse<T>> mutation<T>(
    String mutation, {
    String? url,
    Map<String, dynamic>? variables,
    Map<String, String>? headers,
  }) async {
    try {
      final res = await post(url, {
        'query': mutation,
        'variables': variables,
      }, headers: headers);

      final listError = res.body['errors'];
      if ((listError is List) && listError.isNotEmpty) {
        return GraphQLResponse<T>(
          graphQLErrors: listError
              .map(
                (e) => GraphQLError(
                  code: e['extensions']['code']?.toString(),
                  message: e['message']?.toString(),
                ),
              )
              .toList(),
        );
      }
      return GraphQLResponse<T>.fromResponse(res);
    } on Exception catch (err) {
      return GraphQLResponse<T>(
        graphQLErrors: [GraphQLError(code: null, message: err.toString())],
      );
    }
  }

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  void _checkIfDisposed({bool isHttp = true}) {
    if (_isDisposed) {
      throw 'Can not emit events to disposed clients';
    }
  }

  /// Clear HTTP cache
  void clearCache() {
    _cache.clear();
  }

  /// Get cached response if available and not expired
  CachedResponse<T>? _getCachedResponse<T>(String cacheKey) {
    if (!enableCaching) return null;

    final cached = _cache[cacheKey] as CachedResponse<T>?;
    if (cached != null && !cached.isExpired) {
      return cached;
    } else if (cached != null && cached.isExpired) {
      _cache.remove(cacheKey);
    }
    return null;
  }

  /// Cache response
  void _cacheResponse<T>(String cacheKey, Response<T> response) {
    if (!enableCaching) return;

    _cache[cacheKey] = CachedResponse<T>(
      response: response,
      cachedAt: DateTime.now(),
      maxAge: cacheMaxAge,
    );
  }

  /// Generate cache key for request
  String _generateCacheKey(String url, Map<String, dynamic>? query) {
    final uri = Uri.parse(url);
    final queryParams = {...uri.queryParameters, ...?query};
    final sortedQuery = queryParams.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return '${uri.path}?${sortedQuery.map((e) => '${e.key}=${e.value}').join('&')}';
  }

  /// Retry mechanism for failed requests
  Future<Response<T>> _retryRequest<T>(
    Future<Response<T>> Function() requestFunction,
  ) async {
    int attempts = 0;

    while (attempts <= maxRetries) {
      try {
        final response = await requestFunction();

        // If successful or client error (4xx), don't retry
        if (response.isOk ||
            (response.statusCode != null && response.statusCode! < 500)) {
          return response;
        }

        // Server error (5xx), retry if attempts left
        if (attempts < maxRetries) {
          attempts++;
          if (enableLogging) {
            debugPrint(
              'Request failed with ${response.statusCode}, retrying... ($attempts/$maxRetries)',
            );
          }
          await Future.delayed(retryDelay * attempts);
        } else {
          return response;
        }
      } catch (e) {
        if (attempts < maxRetries) {
          attempts++;
          if (enableLogging) {
            debugPrint(
              'Request failed with error: $e, retrying... ($attempts/$maxRetries)',
            );
          }
          await Future.delayed(retryDelay * attempts);
        } else {
          rethrow;
        }
      }
    }

    // This should never be reached, but just in case
    throw Exception('Max retries exceeded');
  }

  /// Enhanced GET with caching and retry
  Future<Response<T>> getCached<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    bool useCache = true,
  }) async {
    _checkIfDisposed();

    if (useCache && enableCaching) {
      final cacheKey = _generateCacheKey(url, query);
      final cached = _getCachedResponse<T>(cacheKey);
      if (cached != null) {
        if (enableLogging) {
          debugPrint('Cache hit for: $cacheKey');
        }
        return cached.response;
      }
    }

    final response = enableRetry
        ? await _retryRequest(
            () => httpClient.get<T>(
              url,
              headers: headers,
              contentType: contentType,
              query: query,
              decoder: decoder,
            ),
          )
        : await httpClient.get<T>(
            url,
            headers: headers,
            contentType: contentType,
            query: query,
            decoder: decoder,
          );

    if (useCache && enableCaching && response.isOk) {
      final cacheKey = _generateCacheKey(url, query);
      _cacheResponse(cacheKey, response);
      if (enableLogging) {
        debugPrint('Cached response for: $cacheKey');
      }
    }

    return response;
  }

  /// Log request details
  void _logRequest(
    String method,
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) {
    if (!enableLogging) return;

    debugPrint('=== GetConnect Request ===');
    debugPrint('Method: $method');
    debugPrint('URL: $url');
    if (headers != null && headers.isNotEmpty) {
      debugPrint('Headers: $headers');
    }
    if (body != null) {
      debugPrint('Body: $body');
    }
    debugPrint('========================');
  }

  /// Log response details
  void _logResponse(Response response) {
    if (!enableLogging) return;

    debugPrint('=== GetConnect Response ===');
    debugPrint('Status: ${response.statusCode}');
    debugPrint('Headers: ${response.headers}');
    debugPrint('Body: ${response.body}');
    debugPrint('=========================');
  }

  void dispose() {
    if (_sockets != null) {
      for (var socket in sockets) {
        socket.close();
      }
      _sockets?.clear();
      sockets = null;
    }
    if (_httpClient != null) {
      httpClient.close();
      _httpClient = null;
    }
    _cache.clear();
    _isDisposed = true;
  }
}
