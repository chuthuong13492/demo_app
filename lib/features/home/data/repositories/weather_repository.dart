import 'package:demo_app/features/home/data/datasources/weather_api.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';
import 'package:demo_app/features/home/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required WeatherApi weatherApi,
  }) : _weatherApi = weatherApi;

  final WeatherApi _weatherApi;

  @override
  Future<List<WeatherModel>> getListWeather() {
    return _weatherApi.getListWeather();
  }
}
