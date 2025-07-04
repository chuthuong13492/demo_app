import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/utilities/state.dart';
import 'package:demo_app/core/widgets/skeleton/src/skeleton_container.dart';
import 'package:demo_app/features/home/presentation/blocs/image_list/image_list_bloc.dart';
import 'package:demo_app/features/home/presentation/widges/card/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageList extends StatelessWidget {
  const ImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageListBloc, ImageListState>(builder: (context, state) {
      final List<String> images = state.images;

      late final Widget widget;

      if (state is LoadingState && images.isEmpty) {
        widget = _loadingBuilder(context);
      } else if (state is ErrorState && images.isEmpty) {
        widget = _errorBuilder(context, (state as ErrorState).error);
      } else if (images.isEmpty) {
        widget = _emptyBuilder(context);
      } else {
        widget = SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 18,
            childAspectRatio: 1.0,
          ),
          itemCount: state.images.length,
          itemBuilder: (context, index) {
            final String image = state.images[index];

            return ImageCard(
              url: image,
            );
          },
        );
      }

      return widget;
    });
  }

  Widget _errorBuilder(BuildContext context, Failure error) {
    return SliverToBoxAdapter(
      child: Text(error.message),
    );
  }

  Widget _emptyBuilder(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text('Không có dữ liệu'),
    );
  }

  Widget _loadingBuilder(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 18,
        childAspectRatio: 1.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return SkeletonContainer(
          height: null,
          width: null,
          borderRadius: BorderRadius.circular(10),
        );
      },
    );
  }
}
