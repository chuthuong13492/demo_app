import 'package:demo_app/features/home/domain/entities/weather_model.dart';

abstract interface class WeatherRepository {
  Future<List<WeatherModel>> getListWeather();
}
