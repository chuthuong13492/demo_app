part of 'image_list_bloc.dart';

abstract class ImageListEvent extends Equatable {
  const ImageListEvent();

  @override
  List<Object?> get props => [];
}

class ImageListGetEvent extends ImageListEvent {
  const ImageListGetEvent();
}

class ImageListRefreshEvent extends ImageListEvent {
  const ImageListRefreshEvent();
}
