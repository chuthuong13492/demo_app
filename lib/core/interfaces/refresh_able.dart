import 'dart:async';

abstract interface class RefreshAble {
  Stream<Object?> get refreshStream;

  void refresh([Object? identity]);
}
