import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    this.location,
    this.temperature,
  });

  const WeatherModel.empty()
      : this(
          location: null,
          temperature: null,
        );

  final String? location;

  final int? temperature;

  @override
  List<Object?> get props => [
        location,
        temperature,
      ];
}
