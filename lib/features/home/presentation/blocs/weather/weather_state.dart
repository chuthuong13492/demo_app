part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState({
    required this.weather,
  });

  final WeatherModel weather;

  @override
  List<Object?> get props => [
        weather,
      ];
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState()
      : super(
          weather: const WeatherModel.empty(),
        );
}

class _WeatherState extends WeatherState {
  _WeatherState({
    required WeatherState state,
    WeatherModel? weather,
  }) : super(
          weather: weather ?? state.weather,
        );
}
