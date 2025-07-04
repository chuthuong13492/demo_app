part of 'image_list_bloc.dart';

abstract class ImageListState extends Equatable {
  const ImageListState({
    required this.images,
  });

  final List<String> images;

  @override
  List<Object?> get props => [
        images,
      ];
}

class ImageListInitialState extends ImageListState {
  const ImageListInitialState()
      : super(
          images: const [],
        );
}

class _ImageListState extends ImageListState {
  _ImageListState({
    required ImageListState state,
    List<String>? images,
  }) : super(
          images: images ?? state.images,
        );
}
