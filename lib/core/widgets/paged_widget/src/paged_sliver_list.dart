import 'dart:math';

import 'package:flutter/material.dart';

import 'paged_widget.dart';

/// A builder that creates a widget with a [PagedSliverList].
class PagedSliverList<T> extends PagedWidget<T> {
  /// Creates a widget that displays a paged sliver list.
  const PagedSliverList({
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
    required super.onInitial,
    required super.onRefresh,
    required super.onLoadMore,
  });

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

  @override
  PagedWidgetState<T> createState() => PagedSliverListState<T>();
}

/// The state of a [PagedSliverList].
class PagedSliverListState<T> extends PagedWidgetState<T> {
  @override
  PagedSliverList<T> get widget => super.widget as PagedSliverList<T>;

  @override
  Widget build(BuildContext context) {
    if (status == PaginationStatus.loadingFirstPage) {
      return SliverToBoxAdapter(
        child: loadingFirstPageBuilder(context),
      );
    }

    if (status == PaginationStatus.firstPageError) {
      return SliverToBoxAdapter(
        child: firstPageErrorBuilder(context),
      );
    }

    Widget child;

    if (status == PaginationStatus.noItemsFound || pagination.list.isEmpty) {
      child = emptyBuilder(context);
    } else {
      child = SliverList(
        delegate: SliverChildBuilderDelegate(
          itemBuilder,
          childCount: max(pagination.list.length * 2 - 1, 0),
        ),
      );
    }

    return child;
  }

  @override
  Widget itemBuilder(BuildContext context, int index) {
    if (index.isOdd) return separatorBuilder(context, index ~/ 2);

    index = index ~/ 2;

    return super.itemBuilder(context, index);
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
}
