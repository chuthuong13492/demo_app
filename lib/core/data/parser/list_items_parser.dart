import 'package:equatable/equatable.dart';

abstract interface class ListItemsParser<T extends Equatable> {
  const factory ListItemsParser.empty() = _EmptyListItemsParser;

  List<T> toListItems(covariant Object? data);
}

class _EmptyListItemsParser<T extends Equatable> implements ListItemsParser<T> {
  const _EmptyListItemsParser();

  @override
  List<T> toListItems(Object? data) => [];
}
