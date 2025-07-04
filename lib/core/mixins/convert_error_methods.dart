import 'dart:io';

import 'package:dio/dio.dart';

import '../extensions/extensions.dart';

String? getNetworkErrorMessage(DioException error) {
  if (error.type == DioExceptionType.connectionTimeout) {
    return 'Kết nối tới hệ thống mất nhiều thời gian, vui lòng thử lại sau';
  }

  if (error.type == DioExceptionType.sendTimeout) {
    return 'Gửi yêu cầu tới hệ thống mất nhiều thời gian, vui lòng thử lại sau';
  }

  if (error.type == DioExceptionType.receiveTimeout) {
    return 'Hệ thống mất nhiều thời gian phản hồi, vui lòng thử lại sau';
  }

  if (error.type == DioExceptionType.connectionError || error.error is SocketException) {
    return 'Lỗi kết nối mạng, vui lòng thử lại sau';
  }

  if (error.type == DioExceptionType.badResponse) {
    return 'Hệ thống đang gặp sự cố, vui lòng thử lại sau';
  }

  if (error.type == DioExceptionType.badCertificate) {
    return 'Lỗi chứng chỉ kết nối không hợp lệ, vui lòng thử lại sau';
  }

  return null;
}

String? getServiceErrorMessage(DioException error) {
  final Map? errorData = (error.response?.data as Object?).toMapOrNull();

  final String? errorCode = errorData.getStringOrNull('error_code');

  final String? message = errorData.getStringOrNull('message');

  if (errorCode != null) {
    return message.validate(defaultValue: errorCode);
  }

  return null;
}
