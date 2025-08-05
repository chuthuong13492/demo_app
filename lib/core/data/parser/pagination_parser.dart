import 'package:demo_app/core/widgets/paged_widget/src/pagination_model.dart';
import 'package:equatable/equatable.dart';
import 'package:demo_app/core/extensions/extensions.dart';

import 'list_items_parser.dart';

abstract interface class PaginationParser<T extends Equatable> {
  const factory PaginationParser.empty() = _EmptyPaginationParser;

  Pagination<T> toPagination(
    Object? data, {
    required PaginationListItemsParser<T> listItemsParser,
    Map<String, Object?>? paginationData,
    List<Object>? dataList,
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  });
}

class _EmptyPaginationParser<T extends Equatable> implements PaginationParser<T> {
  const _EmptyPaginationParser();

  @override
  Pagination<T> toPagination(
    Object? data, {
    required PaginationListItemsParser<T> listItemsParser,
    Map<String, Object?>? paginationData,
    List<Object>? dataList,
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  }) =>
      Pagination<T>.empty();
}

abstract interface class PaginationListItemsParser<T extends Equatable> implements ListItemsParser<T> {
  factory PaginationListItemsParser.empty() => const _EmptyPaginationListItemParser();

  @override
  List<T> toListItems(List<Object> dataList);
}

class _EmptyPaginationListItemParser<T extends Equatable> implements PaginationListItemsParser<T> {
  const _EmptyPaginationListItemParser();

  @override
  List<T> toListItems(List<Object> dataList) => [];
}

class AMSPaginationParser<T extends Equatable> implements PaginationParser<T> {
  const AMSPaginationParser();

  @override
  Pagination<T> toPagination(
    Object? rawData, {
    required PaginationListItemsParser<T> listItemsParser,
    Map? paginationData,
    List<Object>? dataList,
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  }) {
    final Map? data = rawData.toMapOrNull();

    if (data == null || data.isEmpty) return Pagination<T>.empty();

    paginationData ??= data.getMap('_meta', defaultValue: {});
    dataList ??= data.getList<Object>('items', defaultValue: []);

    page ??= paginationData.getInt('currentPage');
    total ??= paginationData.getInt('totalCount');
    pageSize ??= paginationData.getInt('perPage');
    pageCount ??= paginationData.getInt('pageCount');

    return Pagination<T>(
      list: listItemsParser.toListItems(dataList),
      page: page,
      pageSize: pageSize,
      pageCount: pageCount,
      total: total,
    );
  }
}

class ITSPaginationParser<T extends Equatable> implements PaginationParser<T> {
  const ITSPaginationParser();

  @override
  Pagination<T> toPagination(
    Object? rawData, {
    required PaginationListItemsParser<T> listItemsParser,
    Map? paginationData,
    List<Object>? dataList,
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  }) {
    final Map? data = rawData.toMapOrNull();

    if (data == null || data.isEmpty) return Pagination<T>.empty();

    paginationData ??= data.getMap('_meta', defaultValue: {});
    dataList ??= data.getList<Object>('items', defaultValue: []);

    page ??= paginationData.getInt('currentPage');
    total ??= paginationData.getInt('totalCount');
    pageSize ??= paginationData.getInt('perPage');
    pageCount ??= paginationData.getInt('pageCount');

    return Pagination<T>(
      list: listItemsParser.toListItems(dataList),
      page: page,
      pageSize: pageSize,
      pageCount: pageCount,
      total: total,
    );
  }
}
