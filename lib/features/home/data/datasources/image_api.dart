import 'dart:io';

import 'package:demo_app/config/api_path.dart';
import 'package:demo_app/core/data/datasources/base_api.dart';
import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/core/extensions/extensions.dart';

abstract interface class ImageApi {
  Future<List<String>> getListImage();

  Future<File?> downloadImage({
    required String url,
    required String fileName,
  });
}

class ImageApiImpl extends MainApi implements ImageApi {
  @override
  Future<List<String>> getListImage() async {
    try {
      final path = ApiPath.images();

      final response = await client.get(
        path,
      );

      final List<String> images = response.body.toListOrNull() ?? [];

      return images;
    } catch (error, stackTrace) {
      App.logError(title: '$ImageApi.getListImage', error: error, stackTrace: stackTrace);

      rethrow;
    }
  }

  @override
  Future<File?> downloadImage({
    required String url,
    required String fileName,
  }) async {
    try {
      final response = await client.download(url, fileName: fileName);

      return response.body;
    } catch (error, stackTrace) {
      App.logError(title: '$ImageApi.downloadImage', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
