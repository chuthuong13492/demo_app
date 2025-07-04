import 'dart:async';
import 'dart:io';
import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/features/home/data/datasources/image_api.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepositoryImpl implements ImageRepository {
  ImageRepositoryImpl({
    required ImageApi imageApi,
  }) : _imageApi = imageApi;

  final ImageApi _imageApi;

  @override
  Future<List<String>> getImages() async {
    return _imageApi.getListImage();
  }

  @override
  Future<void> downloadAndResizeImage({
    required String url,
  }) async {
    try {
      final fileName = _getFileNameFromUrl(url);

      final result = await _imageApi.downloadImage(
        url: _reduceImageWidthByHalf(url),
        fileName: fileName,
      );

      if (result == null) {
        return Future.error(
          'File not found',
        );
      }

      final originalBytes = await result.readAsBytes();

      final dir = await getApplicationDocumentsDirectory();

      final outputFile = File('${dir.path}/resized_$fileName');

      await outputFile.writeAsBytes(originalBytes);
    } catch (error, stackTrace) {
      App.logError(title: '$ImageRepositoryImpl.downloadAndResizeImage', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  String _reduceImageWidthByHalf(String url) {
    final uri = Uri.parse(url);
    final params = Map<String, String>.from(uri.queryParameters);

    if (params.containsKey('w')) {
      final width = int.tryParse(params['w'] ?? '');
      if (width != null && width > 0) {
        params['w'] = (width ~/ 2).toString();
      }
    }

    final newUri = uri.replace(queryParameters: params);
    return newUri.toString();
  }

  String _getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    final fileNameFromDl = uri.queryParameters['dl'];
    if (fileNameFromDl != null && fileNameFromDl.isNotEmpty) {
      return fileNameFromDl;
    }

    final segments = uri.pathSegments;
    if (segments.isNotEmpty) {
      return segments.last;
    }

    return 'downloaded_image.jpg';
  }
}

// Future<Uint8List> resizeInIsolate(Uint8List imageBytes) async {
//   final receivePort = ReceivePort();
//   await Isolate.spawn(_resizeEntry, [receivePort.sendPort, imageBytes]);

//   return await receivePort.first;
// }

// void _resizeEntry(List<dynamic> args) async {
//   final SendPort sendPort = args[0];
//   final Uint8List bytes = args[1];

//   final codec = await ui.instantiateImageCodec(bytes);
//   final frame = await codec.getNextFrame();
//   final image = frame.image;

//   final recorder = ui.PictureRecorder();
//   final canvas = ui.Canvas(recorder);
//   final paint = ui.Paint();

//   final halfWidth = image.width ~/ 2;
//   final halfHeight = image.height ~/ 2;

//   canvas.drawImageRect(
//     image,
//     ui.Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
//     ui.Rect.fromLTWH(0, 0, halfWidth.toDouble(), halfHeight.toDouble()),
//     paint,
//   );

//   final picture = recorder.endRecording();
//   final resizedImage = await picture.toImage(halfWidth, halfHeight);
//   final byteData = await resizedImage.toByteData(format: ui.ImageByteFormat.png);

//   sendPort.send(byteData!.buffer.asUint8List());
// }
