part of '../weather_bloc.dart';

abstract class WeatherRefreshState extends _WeatherState {
  WeatherRefreshState({
    required super.state,
    super.weather,
  });
}

class WeatherRefreshLoadingState extends WeatherRefreshState implements LoadingState {
  WeatherRefreshLoadingState({
    required super.state,
  });
}

class WeatherRefreshErrorState extends WeatherRefreshState implements ErrorState {
  WeatherRefreshErrorState({
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

class WeatherRefreshSuccessState extends WeatherRefreshState {
  WeatherRefreshSuccessState({
    required super.state,
    required WeatherModel super.weather,
  });
}
