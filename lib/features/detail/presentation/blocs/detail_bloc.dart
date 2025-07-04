import 'package:demo_app/core/data/models/failure.dart';
import 'package:demo_app/core/utilities/state.dart';
import 'package:demo_app/features/home/domain/repositories/image_repository.dart';
import 'package:demo_app/features/home/domain/usecases/download_image_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'detail_event.dart';
part 'detail_state.dart';
part 'states/download_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required String imageUrl,
    required ImageRepository imageRepository,
  })  : _downloadImageUsecase = DownloadImageUsecase(imageRepository: imageRepository),
        super(
          DetailInitialState(imageUrl: imageUrl),
        ) {
    on<DownloadImageEvent>(_onDownloadImageEvent, transformer: restartable());
  }

  final DownloadImageUsecase _downloadImageUsecase;

  void _onDownloadImageEvent(DownloadImageEvent event, Emitter<DetailState> emit) async {
    emit(DetailDownloadLoadingState(state: state));

    final result = await _downloadImageUsecase.download(url: state.imageUrl);

    result.fold(
      (failure) => emit(DetailDownloadFailedState(state: state, error: failure)),
      (success) => emit(DetailDownloadSuccessState(state: state)),
    );
  }
}
