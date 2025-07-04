import 'package:demo_app/core/data/models/failure.dart';

abstract interface class ErrorState {
  Failure get error;
}

abstract interface class LoadingState {}

abstract interface class EmptyState {}

abstract interface class ActionState {
  DateTime get callTime;
}

abstract interface class ResetState {}
