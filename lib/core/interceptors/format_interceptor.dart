import 'package:dio/dio.dart';

class FormatInterceptor extends Interceptor {
  FormatInterceptor();

  final RegExp invalidCharacters = RegExp(r'[%^{}`|\\<>"]');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _convertQueryParameters(options);

    super.onRequest(options, handler);
  }

  void _convertQueryParameters(RequestOptions options) {
    options.queryParameters.forEach(
      (key, value) {
        if (value is String && invalidCharacters.hasMatch(value)) {
          options.queryParameters[key] = value.replaceAll(invalidCharacters, '');
        }
      },
    );
  }
}
