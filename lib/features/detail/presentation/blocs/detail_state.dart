part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  List<Object?> get props => [
        imageUrl,
      ];
}

class DetailInitialState extends DetailState {
  const DetailInitialState({
    required super.imageUrl,
  });
}

class _DetailState extends DetailState {
  _DetailState({
    required DetailState state,
  }) : super(imageUrl: state.imageUrl);
}
