part of '../image_list_bloc.dart';

abstract class ImageListRefreshState extends _ImageListState {
  ImageListRefreshState({
    required super.state,
    super.images,
  });
}

class ImageListRefreshLoadingState extends ImageListRefreshState implements LoadingState {
  ImageListRefreshLoadingState({
    required super.state,
  });
}

class ImageListRefreshErrorState extends ImageListRefreshState implements ErrorState {
  ImageListRefreshErrorState({
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

class ImageListRefreshSuccessState extends ImageListRefreshState {
  ImageListRefreshSuccessState({
    required super.state,
    required List<String> super.images,
  });
}
