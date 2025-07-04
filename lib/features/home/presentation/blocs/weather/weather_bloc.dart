import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/utilities/state.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';
import 'package:demo_app/features/home/domain/repositories/weather_repository.dart';
import 'package:demo_app/features/home/domain/usecases/get_weather_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';
part 'states/get_state.dart';
part 'states/refresh_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required WeatherRepository weatherRepository,
  })  : _getWeatherUsecase = GetWeatherUsecase(
          weatherRepository: weatherRepository,
        ),
        super(
          WeatherInitialState(),
        ) {
    on<WeatherGetEvent>(_onGetWeather);
    on<WeatherRefreshEvent>(_onRefreshWeather, transformer: restartable());
  }

  final GetWeatherUsecase _getWeatherUsecase;

  void _onGetWeather(WeatherGetEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherGetLoadingState(state: state));
    final result = await _getWeatherUsecase.getWeather();

    result.fold(
      (failure) => emit(WeatherGetErrorState(
        state: state,
        error: failure,
      )),
      (weather) => emit(WeatherGetSuccessState(
        state: state,
        weather: weather,
      )),
    );
  }

  void _onRefreshWeather(WeatherRefreshEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherRefreshLoadingState(state: state));
    final result = await _getWeatherUsecase.getWeather();

    result.fold(
      (failure) => emit(WeatherRefreshErrorState(
        state: state,
        error: failure,
      )),
      (weather) => emit(WeatherRefreshSuccessState(state: state, weather: weather)),
    );
  }
}
