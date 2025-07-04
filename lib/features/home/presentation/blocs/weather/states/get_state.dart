part of '../weather_bloc.dart';

abstract class WeatherGetState extends _WeatherState {
  WeatherGetState({
    required super.state,
    super.weather,
  });
}

class WeatherGetLoadingState extends WeatherGetState implements LoadingState {
  WeatherGetLoadingState({
    required super.state,
  });
}

class WeatherGetErrorState extends WeatherGetState implements ErrorState {
  WeatherGetErrorState({
    required super.state,
    required this.error,
  });

  @override
  final Failure error;

  @override
  List<Object?> get props => [
        ...super.props,
        error,
      ];
}

class WeatherGetSuccessState extends WeatherGetState {
  WeatherGetSuccessState({
    required super.state,
    required WeatherModel super.weather,
  });
}
