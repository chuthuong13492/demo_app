import 'package:demo_app/core/data/models/either.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/extensions/extensions.dart';
import 'package:demo_app/core/mixins/execute_mixin.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';
import 'package:demo_app/features/home/domain/repositories/weather_repository.dart';

class GetWeatherUsecase with ExecuteMixin {
  const GetWeatherUsecase({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  Future<Either<Failure, WeatherModel>> getWeather() async {
    return execute(
      () async {
        final result = await _weatherRepository.getListWeather();

        if (result.isEmpty) {
          return const Left(
            Failure('Không có dữ liệu'),
          );
        }

        final WeatherModel? weather = result.firstWhereOrNull(
          (value) => value.location.validate().contains('Ho Chi Minh'),
        );

        if (weather == null) {
          return const Left(
            Failure('Không tìm thấy dữ liệu'),
          );
        }

        return Right(weather);
      },
      funcTitle: 'GetWeatherUsecase',
      errorMessage: 'Lỗi khi lấy dữ liệu thời tiết',
    );
  }
}
