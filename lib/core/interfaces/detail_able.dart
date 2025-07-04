import 'package:equatable/equatable.dart';

abstract interface class ItemDetailAble<T extends Equatable> {
  T? item([Object? id]);

  Stream<T> getItemStream([Object? id]);

  Future<T> getItem([Object? id]);
}
