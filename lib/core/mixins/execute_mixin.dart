import 'dart:io';

import 'package:demo_app/core/data/models/either.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/core/mixins/convert_error_methods.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

mixin ExecuteMixin {
  @protected
  Future<Either<Failure, T>> execute<T>(
    Future<Either<Failure, T>> Function() func, {
    required String funcTitle,
    required String errorMessage,
    bool takeScreenshotError = true,
    Either<Failure, T>? Function(DioException error)? onDioException,
    Either<Failure, T>? Function(dynamic error, StackTrace? stackTrace)? onOtherException,
  }) async {
    try {
      final response = await func();

      return response;
    } on DioException catch (error, stackTrace) {
      final response = onDioException?.call(error);

      if (response != null) {
        App.logDebug(
          title: funcTitle,
          message: '''
on DioException:
error:$error
stackTrace:$stackTrace
response:${response.fold((error) => error.message, (value) => value.toString())}
              ''',
        );

        return response;
      }

      final String? networkErrorMessage = getNetworkErrorMessage(error);

      if (networkErrorMessage != null) {
        errorMessage = networkErrorMessage;
      }

      final String? serviceErrorMessage = getServiceErrorMessage(error);

      if (serviceErrorMessage != null) {
        errorMessage = serviceErrorMessage;
      }

      App.logDebug(
        title: funcTitle,
        message: errorMessage,
      );

      App.logError(
        title: funcTitle,
        error: error,
        stackTrace: stackTrace,
      );

      return Left(
        Failure(errorMessage),
      );
    } on SocketException catch (error, stackTrace) {
      App.logError(
        title: funcTitle,
        error: error,
        stackTrace: stackTrace,
      );
      return Left(
        Failure(
          'Mất kết nối mạng, vui lòng thử lại sau',
        ),
      );
    } catch (error, stackTrace) {
      final response = onOtherException?.call(error, stackTrace);

      if (response != null) return response;

      App.logError(
        title: funcTitle,
        error: error,
        stackTrace: stackTrace,
        takeScreenshot: takeScreenshotError,
      );
      return Left(
        Failure(errorMessage),
      );
    }
  }
}
