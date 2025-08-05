import 'dart:math';

import 'package:flutter/material.dart';

import 'pagination_model.dart';

// IDENTITY
/// Create a unique key for a model.
typedef PagedItemKey<T> = String Function(T model);

// PAGINATION
/// Get a [Pagination] from an initial request.
typedef PagedOnInitial<T> = Future<Pagination<T>> Function();

/// Get a [Pagination] from a refresh request.
typedef PagedOnRefresh<T> = Future<Pagination<T>> Function();

/// Get a [Pagination] of [page] from a load more request.
typedef PagedOnLoadMore<T> = Future<Pagination<T>> Function(int page);

// WIDGET
/// Create an item widget
typedef PagedItemBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

/// Create a separator widget
typedef PagedSeparatorBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T model,
);

/// Create an empty widget
typedef PagedEmptyBuilder = Widget Function(BuildContext context);

/// Create a loading first page widget
typedef PagedLoadingFirstPageBuilder = Widget Function(BuildContext context);

/// Create a loading more widget
typedef PagedLoadingMoreBuilder = Widget Function(BuildContext context);

/// Create a first page error widget
typedef PagedFirstPageErrorBuilder = Widget Function(
  BuildContext context,
  String? error,
  void Function()? onReload,
);

/// Create a subsequent page error widget
typedef PagedSubsequentPageErrorBuilder = Widget Function(
  BuildContext context,
  String? error,
  void Function()? onReload,
);

/// Create an end widget
typedef PagedEndBuilder = Widget Function(BuildContext context);

/// The status of a [Pagination].
enum PaginationStatus {
  /// The initial state.
  initial,

  /// The first page is loading.
  loadingFirstPage,

  /// A subsequent page is loading.
  loadingMore,

  /// The pagination is completed.
  completed,

  /// No items were found.
  noItemsFound,

  /// The pagination is normal, can do load more or refresh
  ongoing,

  /// The first page has an error.
  firstPageError,

  /// A subsequent page has an error.
  subsequentPageError,
}

/// A widget that displays a [Pagination].
abstract class PagedWidget<T> extends StatefulWidget {
  /// Creates a [PagedWidget].
  const PagedWidget({
    super.key,
    this.pagination,
    this.invisibleItemsThreshold = 3,
    required this.itemKey,
    required this.itemBuilder,
    required this.onInitial,
    required this.onRefresh,
    required this.onLoadMore,
  });

  /// The pagination to use.
  final Pagination<T>? pagination;

  /// The number of invisible items to trigger a load more.
  final int invisibleItemsThreshold;

  /// Create a unique key for a model.
  final PagedItemKey<T> itemKey;

  /// Create an item widget
  final PagedItemBuilder<T> itemBuilder;

  /// Get a [Pagination] from an initial request.
  final PagedOnInitial<T> onInitial;

  /// Get a [Pagination] from a refresh request.
  final PagedOnRefresh<T> onRefresh;

  /// Get a [Pagination] of [page] from a load more request.
  final PagedOnLoadMore<T> onLoadMore;

  @override
  PagedWidgetState<T> createState();
}

/// The state of a [PagedWidget].
abstract class PagedWidgetState<T> extends State<PagedWidget<T>> {
  late Pagination<T> _pagination;

  /// The pagination to use.
  Pagination<T> get pagination => _pagination;

  set pagination(Pagination<T> value) {
    _pagination = value;
    updateState(getStatus(_pagination), forcedReload: true);
  }

  late PaginationStatus _status;

  /// The status of the pagination.
  PaginationStatus get status => _status;

  @protected
  set status(PaginationStatus value) {
    _status = value;
  }

  /// Avoids duplicate requests on rebuilds.
  bool _hasRequestedNextPage = false;

  @override
  void initState() {
    super.initState();
    _pagination = widget.pagination ?? Pagination.empty();

    status = getStatus(pagination);

    if (status == PaginationStatus.initial) {
      onInitial();
    }
  }

  /// on init pagination
  Future<void> onInitial() async {
    updateState(PaginationStatus.loadingFirstPage);
    _pagination = await widget.onInitial();
    updateState(getStatus(pagination));
  }

  /// on load more pagination
  Future<void> onLoadMore() async {
    updateState(PaginationStatus.loadingMore);
    _pagination = await widget.onLoadMore(pagination.page + 1);
    updateState(getStatus(pagination));
  }

  /// on refresh pagination
  Future<void> onRefresh() async {
    _pagination = await widget.onRefresh();
    updateState(getStatus(pagination), forcedReload: true);
  }

  /// Update the state of the pagination.
  void updateState(
    PaginationStatus value, {
    bool forcedReload = false,
  }) {
    if (status != value || forcedReload) {
      status = value;
      if (status == PaginationStatus.ongoing) {
        _hasRequestedNextPage = false;
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Get the status of a [Pagination].
  PaginationStatus getStatus(Pagination pagination) {
    if (pagination.page == 0) {
      if (pagination.error == null) {
        return PaginationStatus.initial;
      } else {
        return PaginationStatus.firstPageError;
      }
    }

    if (pagination.list.isNotEmpty && pagination.isLast) {
      return PaginationStatus.completed;
    }

    if (pagination.total < 1 || pagination.list.isEmpty) {
      return PaginationStatus.noItemsFound;
    }

    if (pagination.error != null) {
      return PaginationStatus.subsequentPageError;
    }

    return PaginationStatus.ongoing;
  }

  /// Check if the scroll is at the bottom and request the next page.
  @protected
  void checkScrollToBottom(int index) {
    if (status == PaginationStatus.ongoing && !_hasRequestedNextPage) {
      final int newPageRequestTriggerIndex = max(0, pagination.list.length - widget.invisibleItemsThreshold);

      final bool isBuildingTriggerIndexItem = index == newPageRequestTriggerIndex;

      if (!pagination.isLast && isBuildingTriggerIndexItem) {
        // Schedules the request for the end of this frame.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onLoadMore();
        });
        _hasRequestedNextPage = true;
      }
    }
  }

  /// Create an item widget
  @protected
  Widget itemBuilder(BuildContext context, int index) {
    checkScrollToBottom(index);

    Widget item = widget.itemBuilder(context, index, pagination.list[index]);

    if (index == pagination.list.length - 1) {
      switch (status) {
        case PaginationStatus.loadingMore:
          item = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              item,
              separatorBuilder(context, index),
              loadingMoreBuilder(context),
            ],
          );
        case PaginationStatus.subsequentPageError:
          item = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              item,
              subsequentPageErrorBuilder(context),
            ],
          );
        case PaginationStatus.completed:
          item = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              item,
              endBuilder(context),
            ],
          );
        default:
      }
    }

    return SizedBox(
      key: Key(widget.itemKey(pagination.list[index])),
      child: item,
    );
  }

  /// Create a separator widget
  @protected
  Widget emptyBuilder(BuildContext context);

  /// Create a separator widget
  @protected
  Widget separatorBuilder(BuildContext context, int index);

  /// Create a loading more widget
  @protected
  Widget loadingMoreBuilder(BuildContext context);

  /// Create a loading first page widget
  @protected
  Widget loadingFirstPageBuilder(BuildContext context);

  /// Create a first page error widget
  @protected
  Widget firstPageErrorBuilder(BuildContext context);

  /// Create a subsequent page error widget
  @protected
  Widget subsequentPageErrorBuilder(BuildContext context);

  /// Create an end widget
  @protected
  Widget endBuilder(BuildContext context);
}
