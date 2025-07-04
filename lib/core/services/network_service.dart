import 'dart:async';
import 'dart:io';

import 'package:demo_app/core/interceptors/app_log_interceptor.dart';
import 'package:demo_app/core/interceptors/format_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path_provider/path_provider.dart';

class AuthNetworkService extends DioNetworkService {
  AuthNetworkService._({
    required super.dio,
  }) : _baseDio = dio;

  final Dio? _baseDio;

  static Dio _dioBuilder() {
    Dio dio;
    if (_instance?._baseDio != null) {
      dio = Dio(_instance!._baseDio!.options);
    } else {
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://mocki.io/v1/',
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          sendTimeout: const Duration(seconds: 60),
        ),
      );
    }

    dio.interceptors.add(FormatInterceptor());

    return dio;
  }

  static AuthNetworkService? _instance;
  static AuthNetworkService get instance {
    _instance ??= AuthNetworkService._(
      // dio: _dioBuilder()..interceptors.add(AuthInterceptor(retryDioBuilder: _dioBuilder)),
      dio: _dioBuilder(),
    );

    return _instance!;
  }
}

class NoAuthNetworkService extends AuthNetworkService {
  NoAuthNetworkService._({
    required super.dio,
  }) : super._();

  static NoAuthNetworkService? _instance;
  static NoAuthNetworkService get instance {
    _instance ??= NoAuthNetworkService._(
      dio: AuthNetworkService._dioBuilder(),
    );

    return _instance!;
  }
}

class _CustomDioNetworkService extends DioNetworkService {
  _CustomDioNetworkService({
    required super.dio,
  });
}

abstract class DioNetworkService implements NetworkService {
  DioNetworkService({
    required Dio dio,
  }) : _dio = dio {
    _dio.interceptors.add(AppLogInterceptor());

    // Disable certificate check (only for trusted domain)
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (_, __, ___) => true;
        return client;
      },
    );
  }

  factory DioNetworkService.custom({required Dio dio}) => _CustomDioNetworkService(dio: dio);

  final Dio _dio;
  Dio get dio => _dio;

  bool _defaultValidateStatus(int? status) {
    return status != null && status >= 200 && status < 300;
  }

  @override
  Future<NetworkResponse<T>> get<T extends Object>(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    ResponseType? responseType,
    Object? data,
    Map<String, Object?>? extra,
    ProgressCallback? onReceiveProgress,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      data: data,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(
        extra: extra,
        headers: headers,
        responseType: responseType,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    return _toNetworkResponse<T>(response);
  }

  @override
  Future<NetworkResponse<T>> post<T extends Object>(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    ResponseType? responseType,
    Object? data,
    Map<String, Object?>? extra,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.post<T>(
      path,
      queryParameters: queryParameters,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(
        extra: extra,
        headers: headers,
        responseType: responseType,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );
    return _toNetworkResponse<T>(response);
  }

  @override
  Future<NetworkResponse<T>> put<T extends Object>(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    ResponseType? responseType,
    Object? data,
    Map<String, Object?>? extra,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.put<T>(
      path,
      queryParameters: queryParameters,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(
        extra: extra,
        headers: headers,
        responseType: responseType,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    return _toNetworkResponse<T>(response);
  }

  @override
  Future<NetworkResponse<T>> patch<T extends Object>(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    ResponseType? responseType,
    Object? data,
    Map<String, Object?>? extra,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.patch<T>(
      path,
      queryParameters: queryParameters,
      data: data,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      options: Options(
        extra: extra,
        headers: headers,
        responseType: responseType,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    return _toNetworkResponse<T>(response);
  }

  @override
  Future<NetworkResponse<T>> delete<T extends Object>(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    ResponseType? responseType,
    Object? data,
    Map<String, Object?>? extra,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.delete<T>(
      path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      options: Options(
        extra: extra,
        headers: headers,
        responseType: responseType,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );
    return _toNetworkResponse<T>(response);
  }

  Future<NetworkResponse<File>> download(
    String path, {
    required String fileName,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    Map<String, Object?>? extra,
    ProgressCallback? onReceiveProgress,
    bool? Function(int? status)? validateStatus,
    Duration? receiveTimeout = const Duration(minutes: 10),
    Duration? sendTimeout,
    CancelToken? cancelToken,
  }) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String savePath = '${tempDir.path}/$fileName';

    final response = await _dio.download(
      path,
      savePath,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      options: Options(
        extra: extra,
        headers: headers,
        validateStatus: (status) {
          return validateStatus?.call(status) ?? _defaultValidateStatus(status);
        },
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
      ),
    );

    return NetworkResponse<File>(
      header: response.headers.map,
      body: File(savePath),
      statusCode: response.statusCode,
    );
  }

  NetworkResponse<T> _toNetworkResponse<T extends Object>(Response response) {
    return NetworkResponse<T>(
      header: response.headers.map,
      body: response.data,
      statusCode: response.statusCode,
    );
  }

  void config({
    String? baseUrl,
  }) {
    _dio.options.baseUrl = baseUrl ?? _dio.options.baseUrl;
  }
}

abstract interface class NetworkService {
  /// Get request
  Future<NetworkResponse<T>> get<T extends Object>(
    String path, {
    Map<String, Object?>? queryParameters,
    Object? data,
  });

  /// Post request
  Future<NetworkResponse<T>> post<T extends Object>(
    String path, {
    Map<String, Object?>? queryParameters,
    Object? data,
  });

  /// Put request
  Future<NetworkResponse<T>> put<T extends Object>(
    String path, {
    Map<String, Object?>? queryParameters,
    Object? data,
  });

  /// Patch request
  Future<NetworkResponse<T>> patch<T extends Object>(
    String path, {
    Map<String, Object?>? queryParameters,
    Object? data,
  });

  /// Delete request
  Future<NetworkResponse<T>> delete<T extends Object>(
    String path, {
    Map<String, Object?> queryParameters,
    Object? data,
  });
}

/// Network response
class NetworkResponse<T extends Object> {
  /// Constructor for network response
  NetworkResponse({
    required this.header,
    required this.statusCode,
    required this.body,
  });

  /// Body
  final T? body;

  /// Status code
  final int? statusCode;

  /// Header
  final Map<String, Object?>? header;
}
