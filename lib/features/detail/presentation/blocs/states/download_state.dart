part of '../detail_bloc.dart';

abstract class DetailDownloadState extends _DetailState {
  DetailDownloadState({
    required super.state,
  });
}

class DetailDownloadLoadingState extends DetailDownloadState implements LoadingState {
  DetailDownloadLoadingState({
    required super.state,
  });
}

class DetailDownloadFailedState extends DetailDownloadState implements ErrorState {
  DetailDownloadFailedState({
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

class DetailDownloadSuccessState extends DetailDownloadState {
  DetailDownloadSuccessState({
    required super.state,
  });
}
