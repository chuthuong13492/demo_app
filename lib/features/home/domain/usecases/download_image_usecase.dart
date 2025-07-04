import 'package:demo_app/core/data/models/either.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/mixins/execute_mixin.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';

class DownloadImageUsecase with ExecuteMixin {
  DownloadImageUsecase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  final ImageRepository _imageRepository;

  Future<Either<Failure, void>> download({
    required String url,
  }) async {
    return execute(
      () async {
        await _imageRepository.downloadAndResizeImage(url: url);

        return Right(null);
      },
      funcTitle: '$DownloadImageUsecase.download',
      errorMessage: 'Tải ảnh thất bại',
    );
  }
}
