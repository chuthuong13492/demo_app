import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/extensions/src/string/src/string_format.dart';
import 'package:demo_app/core/utilities/state.dart';
import 'package:demo_app/core/widgets/skeleton/skeleton.dart';
import 'package:demo_app/features/home/domain/entities/weather_model.dart';
import 'package:demo_app/features/home/presentation/blocs/weather/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final WeatherModel weather = state.weather;

        late final Widget widget;

        if (state is LoadingState && (weather == WeatherModel.empty())) {
          widget = _loadingBuilder(context);
        } else if (state is ErrorState && (weather == WeatherModel.empty())) {
          widget = _errorBuilder(context, (state as ErrorState).error);
        } else if (weather == WeatherModel.empty()) {
          widget = _emptyBuilder(context);
        } else {
          widget = _weatherBuilder(context, weather);
        }

        return SliverToBoxAdapter(
          child: widget,
        );
      },
    );
  }

  Widget _loadingBuilder(BuildContext context) {
    return SkeletonParagraph(
      lines: 2,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _emptyBuilder(BuildContext context) {
    return Text('Không có dữ liệu');
  }

  Widget _errorBuilder(BuildContext context, Failure error) {
    return Text(error.message);
  }

  Widget _weatherBuilder(BuildContext context, WeatherModel weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          weather.location.validate(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '#°C'.replaceFirst(
            '#',
            weather.temperature.toString(),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
