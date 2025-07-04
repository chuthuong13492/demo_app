import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/utilities/state.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';
import 'package:demo_app/features/home/domain/usecases/get_list_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';
part 'states/get_state.dart';
part 'states/refresh_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  ImageListBloc({
    required ImageRepository imageRepository,
  })  : _getListImageUsecase = GetListImageUsecase(
          imageRepository: imageRepository,
        ),
        super(
          ImageListInitialState(),
        ) {
    on<ImageListGetEvent>(_onGetImageList);
    on<ImageListRefreshEvent>(_onRefreshImageList, transformer: restartable());
  }

  final GetListImageUsecase _getListImageUsecase;

  void _onGetImageList(ImageListGetEvent event, Emitter<ImageListState> emit) async {
    emit(ImageListGetLoadingState(state: state));
    final result = await _getListImageUsecase.getListImage();

    result.fold(
      (failure) => emit(ImageListGetErrorState(state: state, error: failure)),
      (images) => emit(ImageListGetSuccessState(state: state, images: images)),
    );
  }

  void _onRefreshImageList(ImageListRefreshEvent event, Emitter<ImageListState> emit) async {
    emit(ImageListRefreshLoadingState(state: state));
    final result = await _getListImageUsecase.getListImage();

    result.fold(
      (failure) => emit(ImageListRefreshErrorState(state: state, error: failure)),
      (images) => emit(ImageListRefreshSuccessState(state: state, images: images)),
    );
  }
}
