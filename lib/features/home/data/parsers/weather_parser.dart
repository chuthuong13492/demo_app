import 'package:demo_app/core/data/parser/item_parser.dart';
import 'package:demo_app/core/data/parser/list_items_parser.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';
import 'package:demo_app/core/extensions/extensions.dart';

abstract interface class WeatherParser implements ItemParser<WeatherModel>, ListItemsParser<WeatherModel> {
  const factory WeatherParser.empty() = _EmptyWeatherParser;
}

class _EmptyWeatherParser implements WeatherParser {
  const _EmptyWeatherParser();

  @override
  WeatherModel toItem(Object? data) => const WeatherModel.empty();

  @override
  List<WeatherModel> toListItems(covariant Object? data) => [];
}

enum WeatherParam {
  location,
  temperature,
}

class WeatherParserImpl implements WeatherParser {
  const WeatherParserImpl();

  @override
  WeatherModel toItem(Object? raw) {
    final Map? data = raw.toMapOrNull();

    if (data == null || data.isEmpty) return const WeatherModel.empty();

    return WeatherModel(
      location: data.getStringOrNull(WeatherParam.location.name),
      temperature: data.getIntOrNull(WeatherParam.temperature.name),
    );
  }

  @override
  List<WeatherModel> toListItems(covariant Object? data) {
    final List<WeatherModel> list = [];

    final List<Object?> dataList = data.toListOrNull() ?? [];

    for (final Object? dataItem in dataList) {
      final WeatherModel item = toItem(dataItem);

      if (item != const WeatherModel.empty()) {
        list.add(item);
      }
    }

    return list;
  }
}
