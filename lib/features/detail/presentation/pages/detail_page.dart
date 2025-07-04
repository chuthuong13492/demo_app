import 'package:demo_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:demo_app/features/detail/presentation/widgets/action_widget.dart';
import 'package:demo_app/features/detail/presentation/widgets/image_widget.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';
import 'package:demo_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailBloc>(
      create: (context) => DetailBloc(
        imageUrl: url,
        imageRepository: Repository.get<ImageRepository>(),
      ),
      child: _Page(url: url),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.url});

  final String url;

  void _listener(BuildContext context, DetailState state) {
    if (state is DetailDownloadSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tải ảnh thành công!'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailBloc, DetailState>(
      listener: _listener,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ActionWidget(),
              Expanded(
                  child: Center(
                child: ImageWidget(url: url),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
