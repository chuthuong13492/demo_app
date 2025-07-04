import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../extensions/app_extension/app_extension.dart';

class AppLogInterceptor extends TalkerDioLogger {
  AppLogInterceptor({
    bool printRequestData = true,
    bool printResponseData = true,
  }) : super(
          talker: debugTalker,
          settings: TalkerDioLoggerSettings(
            printRequestData: printRequestData,
            printResponseData: printResponseData,
          ),
        );

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var responseData = response.data;

    if (response.requestOptions.responseType == ResponseType.bytes) {
      responseData = 'ResponseType: ${responseData.runtimeType}';
      configure(
        printResponseData: false,
      );
    }

    super.onResponse(response, handler);

    configure(
      printResponseData: true,
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final Response? response = err.response;

    var responseData = response?.data;

    if (response?.requestOptions.responseType == ResponseType.bytes) {
      responseData = 'ResponseType: ${responseData.runtimeType}';
      configure(
        printResponseData: false,
      );
    }

    super.onError(err, handler);

    configure(
      printResponseData: true,
    );
  }
}
