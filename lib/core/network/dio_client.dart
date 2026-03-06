import 'package:dio/dio.dart';

class DioClient {
  static const _baseUrl = 'https://api.pexels.com/v1';

  static const _apiKey = 'fprQIHglhttpOEiWHe8fewDh2PZcwsRitLzE37bSQFUFgz8sCaWhMYid';

  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Authorization': _apiKey},
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }
}

// ---------------------------------------------------------------------------
// Interceptors
// ---------------------------------------------------------------------------

/// Ensures the API key header is always present on every request.
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Header is already set in BaseOptions, this interceptor can
    // refresh or replace the token in the future if needed.
    handler.next(options);
  }
}

/// Logs every request and response in debug mode.
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[DioClient] → ${options.method} ${options.uri}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '[DioClient] ← ${response.statusCode} ${response.requestOptions.uri}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      '[DioClient] ✖ ${err.response?.statusCode} ${err.requestOptions.uri}',
    );
    print('[DioClient]   ${err.message}');
    handler.next(err);
  }
}

/// Converts Dio errors into human-readable messages.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timed out. Check your internet.');
      case DioExceptionType.badResponse:
        final status = err.response?.statusCode;
        if (status == 401) {
          throw NetworkException('Invalid API key. Check your Pexels key.');
        } else if (status == 429) {
          throw NetworkException('Rate limit exceeded. Try again later.');
        } else {
          throw NetworkException('Server error ($status).');
        }
      case DioExceptionType.connectionError:
        throw NetworkException('No internet connection.');
      default:
        throw NetworkException('Unexpected error: ${err.message}');
    }
  }
}

/// A typed exception for network-related errors.
class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}
