import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  /// Constructs a failure instance.
  const Failure(this.message);

  /// The message of the failure.
  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}
