import 'package:demo_app/core/data/models/either.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/mixins/execute_mixin.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';

class GetListImageUsecase with ExecuteMixin {
  GetListImageUsecase({
    required ImageRepository imageRepository,
  }) : _imageRepository = imageRepository;

  final ImageRepository _imageRepository;

  Future<Either<Failure, List<String>>> getListImage() async {
    return execute(
      () async {
        final result = await _imageRepository.getImages();

        return Right(result);
      },
      funcTitle: '$GetListImageUsecase.getListImage',
      errorMessage: 'Lấy danh sách ảnh thất bại',
    );
  }
}
