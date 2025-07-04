import 'package:equatable/equatable.dart';

abstract interface class ItemParser<T extends Equatable> {
  T toItem(Object? data);
}
