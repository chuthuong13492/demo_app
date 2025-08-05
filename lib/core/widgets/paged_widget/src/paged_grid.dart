import 'package:flutter/material.dart';
import 'paged_widget.dart';

/// A builder that creates a widget with a [PagedGrid].
class PagedGrid<T> extends PagedWidget<T> {
  /// Creates a widget that displays a paged grid.
  const PagedGrid({
    super.key,
    required super.itemKey,
    super.pagination,
    required super.itemBuilder,
    this.emptyBuilder,
    this.loadingFirstPageBuilder,
    this.loadingMoreBuilder,
    this.firstPageErrorBuilder,
    this.subsequentPageErrorBuilder,
    this.endBuilder,
    this.padding,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    required super.onInitial,
    required super.onRefresh,
    required super.onLoadMore,
    this.hasRefreshIndicator = true,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
  });

  /// The scroll controller to use.
  final ScrollController? scrollController;

  /// Creates an empty widget.
  final PagedEmptyBuilder? emptyBuilder;

  /// Creates a loading first page widget.
  final PagedLoadingFirstPageBuilder? loadingFirstPageBuilder;

  /// Creates a loading more widget.
  final PagedLoadingMoreBuilder? loadingMoreBuilder;

  /// Creates a first page error widget.
  final PagedFirstPageErrorBuilder? firstPageErrorBuilder;

  /// Creates a subsequent page error widget.
  final PagedSubsequentPageErrorBuilder? subsequentPageErrorBuilder;

  /// Creates an end widget.
  final PagedEndBuilder? endBuilder;

  /// The padding to use.
  final EdgeInsets? padding;

  /// Whether to use a refresh indicator.
  final bool hasRefreshIndicator;

  /// The scroll direction of the grid.
  final Axis scrollDirection;

  /// The number of columns in the grid.
  final int crossAxisCount;

  /// The spacing between rows.
  final double mainAxisSpacing;

  /// The spacing between columns.
  final double crossAxisSpacing;

  /// The aspect ratio of grid items.
  final double childAspectRatio;

  /// The extent of the main axis.
  final double? mainAxisExtent;

  @override
  PagedWidgetState<T> createState() => PagedGridState<T>();
}

/// The state of a [PagedGrid].
class PagedGridState<T> extends PagedWidgetState<T> {
  @override
  PagedGrid<T> get widget => super.widget as PagedGrid<T>;

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
      child = GridView.builder(
        controller: widget.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: widget.scrollDirection,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: widget.padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          childAspectRatio: widget.childAspectRatio,
          mainAxisExtent: widget.mainAxisExtent,
        ),
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
  Widget endBuilder(BuildContext context) {
    return widget.endBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget firstPageErrorBuilder(BuildContext context) {
    return widget.firstPageErrorBuilder?.call(context, pagination.error, onRefresh) ?? const SizedBox.shrink();
  }

  @override
  Widget loadingFirstPageBuilder(BuildContext context) {
    return widget.loadingFirstPageBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget loadingMoreBuilder(BuildContext context) {
    return widget.loadingMoreBuilder?.call(context) ?? const SizedBox.shrink();
  }

  @override
  Widget separatorBuilder(BuildContext context, int index) {
    return const SizedBox.shrink();
  }

  @override
  Widget subsequentPageErrorBuilder(BuildContext context) {
    return widget.subsequentPageErrorBuilder?.call(context, pagination.error, onLoadMore) ?? const SizedBox.shrink();
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
