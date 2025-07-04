import 'package:demo_app/core/widgets/app_app_bar.dart';
import 'package:demo_app/features/home/domain/repositories/weather_repository.dart';
import 'package:demo_app/features/home/presentation/blocs/image_list/image_list_bloc.dart';
import 'package:demo_app/features/home/presentation/blocs/weather/weather_bloc.dart';
import 'package:demo_app/features/home/presentation/widges/image_list.dart';
import 'package:demo_app/features/home/presentation/widges/weather.dart';
import 'package:demo_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(
            weatherRepository: Repository.get<WeatherRepository>(),
          )..add(const WeatherGetEvent()),
        ),
        BlocProvider<ImageListBloc>(
          create: (context) => ImageListBloc(
            imageRepository: Repository.get<ImageRepository>(),
          )..add(const ImageListGetEvent()),
        ),
      ],
      child: const _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ImageListBloc>().add(const ImageListRefreshEvent());
    context.read<WeatherBloc>().add(const WeatherRefreshEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: 'Demo App',
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              Weather(),
              SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
              ImageList(),
            ],
          ),
        ),
      ),
    );
  }
}
