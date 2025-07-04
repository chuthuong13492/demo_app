part of '../image_list_bloc.dart';

abstract class ImageListGetState extends _ImageListState {
  ImageListGetState({
    required super.state,
    super.images,
  });
}

class ImageListGetLoadingState extends ImageListGetState implements LoadingState {
  ImageListGetLoadingState({
    required super.state,
  });
}

class ImageListGetErrorState extends ImageListGetState implements ErrorState {
  ImageListGetErrorState({
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

class ImageListGetSuccessState extends ImageListGetState {
  ImageListGetSuccessState({
    required super.state,
    required List<String> super.images,
  });
}
