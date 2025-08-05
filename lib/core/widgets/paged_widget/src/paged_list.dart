import 'package:flutter/material.dart';

import 'paged_widget.dart';

/// A builder that creates a widget with a [PagedList].
class PagedList<T> extends PagedWidget<T> {
  /// Creates a widget that displays a paged list.
  const PagedList({
    super.key,
    required super.itemKey,
    super.pagination,
    required super.itemBuilder,
    this.emptyBuilder,
    this.loadingFirstPageBuilder,
    this.loadingMoreBuilder,
    this.separatorBuilder,
    this.firstPageErrorBuilder,
    this.subsequentPageErrorBuilder,
    this.endBuilder,
    this.padding,
    this.scrollController,
    required super.onInitial,
    required super.onRefresh,
    required super.onLoadMore,
    this.hasRefreshIndicator = true,
  });

  /// The scroll controller to use.
  final ScrollController? scrollController;

  /// Creates a empty widget
  final PagedEmptyBuilder? emptyBuilder;

  /// Creates a separator widget
  final PagedSeparatorBuilder<T>? separatorBuilder;

  /// Creates a loading first page widget
  final PagedLoadingFirstPageBuilder? loadingFirstPageBuilder;

  /// Creates a loading more widget
  final PagedLoadingMoreBuilder? loadingMoreBuilder;

  /// Creates a first page error widget
  final PagedFirstPageErrorBuilder? firstPageErrorBuilder;

  /// Creates a subsequent page error widget
  final PagedSubsequentPageErrorBuilder? subsequentPageErrorBuilder;

  /// Creates a end widget
  final PagedEndBuilder? endBuilder;

  /// The padding to use.
  final EdgeInsets? padding;

  /// Whether to use a refresh indicator.
  final bool hasRefreshIndicator;

  @override
  PagedWidgetState<T> createState() => PagedListState<T>();
}

/// The state of a [PagedList].
class PagedListState<T> extends PagedWidgetState<T> {
  @override
  PagedList<T> get widget => super.widget as PagedList<T>;

  @override
  Widget build(BuildContext context) {
    if (status == PaginationStatus.loadingFirstPage) {
      return loadingFirstPageBuilder(context);
    }

    if (status == PaginationStatus.firstPageError) {
      return firstPageErrorBuilder(context);
    }

    Widget child;

    if (status == PaginationStatus.noItemsFound || pagination.list.isEmpty) {
      child = emptyBuilder(context);
    } else {
      child = ListView.separated(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: widget.padding,
        separatorBuilder: separatorBuilder,
        itemCount: pagination.list.length,
        itemBuilder: itemBuilder,
      );
    }

    return refreshIndicatorBuilder(
      child,
      onRefresh,
    );
  }

  @override
  Widget emptyBuilder(BuildContext context) {
    return widget.emptyBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget separatorBuilder(BuildContext context, int index) {
    return widget.separatorBuilder?.call(context, index, pagination.list[index]) ?? const SizedBox(height: 16);
  }

  @override
  Widget loadingMoreBuilder(BuildContext context) {
    return widget.loadingMoreBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget loadingFirstPageBuilder(BuildContext context) {
    return widget.loadingFirstPageBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget firstPageErrorBuilder(BuildContext context) {
    return widget.firstPageErrorBuilder?.call(context, pagination.error, onRefresh) ?? const SizedBox.shrink();
  }

  @override
  Widget subsequentPageErrorBuilder(BuildContext context) {
    return widget.subsequentPageErrorBuilder?.call(context, pagination.error, onLoadMore) ?? const SizedBox.shrink();
  }

  @override
  Widget endBuilder(BuildContext context) {
    return widget.endBuilder?.call(context) ?? const SizedBox.shrink();
  }

  /// Builds a widget with a refresh indicator.
  Widget refreshIndicatorBuilder(
    Widget child,
    Future<void> Function() onRefresh,
  ) {
    if (widget.hasRefreshIndicator) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: child,
      );
    } else {
      return child;
    }
  }
}
