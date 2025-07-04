import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../parser/list_items_parser.dart';

class ListDTO<T extends Equatable> extends UnmodifiableListView<T> {
  ListDTO(
    this.data, {
    required this.listItemsParser,
    Iterable<T>? source,
  }) : super(source ?? listItemsParser.toListItems(data));

  final Object? data;

  final ListItemsParser<T> listItemsParser;
}
