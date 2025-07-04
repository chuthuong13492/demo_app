import 'package:equatable/equatable.dart';

abstract class ListItemAble<T extends Equatable> {
  List<T> items([Object? id]);
  Stream<List<T>> getListStream();
  Future<List<T>> getList([Object? id]);
}
