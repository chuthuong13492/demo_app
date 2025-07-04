import 'package:demo_app/config/api_path.dart';
import 'package:demo_app/core/data/datasources/base_api.dart';
import 'package:demo_app/core/data/models/list_dto.dart';
import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/features/home/data/parsers/weather_parser.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';

abstract interface class WeatherApi {
  WeatherParser get parser;

  Future<ListDTO<WeatherModel>> getListWeather();
}

class WeatherApiImpl extends MainApi implements WeatherApi {
  @override
  WeatherParser get parser => const WeatherParserImpl();

  @override
  Future<ListDTO<WeatherModel>> getListWeather() async {
    try {
      final path = ApiPath.weather();

      final response = await client.get(
        path,
      );

      return ListDTO(
        response.body,
        listItemsParser: parser,
      );
    } catch (error, stackTrace) {
      App.logError(title: '$WeatherApi.getListWeather', error: error, stackTrace: stackTrace);

      rethrow;
    }
  }
}
