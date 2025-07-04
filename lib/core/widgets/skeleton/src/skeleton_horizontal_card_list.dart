import 'package:flutter/material.dart';

import '../skeleton.dart' show SkeletonHorizontalCard;

/// Creates a horizontal skeleton cards
typedef SkeletonHorizontalCardBuilder = Widget Function(BuildContext context, int index);

/// Creates a separator between horizontal skeleton cards
typedef SkeletonHorizontalListSperatorBuilder = Widget Function(BuildContext context, int index);

/// A widget that creates a list of horizontal skeleton cards
class SkeletonHorizontalCardList extends StatelessWidget {
  /// Creates a horizontal skeleton card list
  const SkeletonHorizontalCardList({
    super.key,
    required this.itemCount,
    this.padding,
    this.itemBuilder,
    this.separatorBuilder,
    this.scrollDirection = Axis.vertical,
  });

  /// The number of items in the list
  final int itemCount;

  /// The padding around the list
  final EdgeInsets? padding;

  /// The axis of the list
  final Axis scrollDirection;

  /// The builder for the items in the list
  final SkeletonHorizontalCardBuilder? itemBuilder;

  /// The builder for the separators between items in the list
  final SkeletonHorizontalListSperatorBuilder? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding ?? EdgeInsets.zero,
      itemCount: itemCount,
      itemBuilder: buildItem,
      separatorBuilder: buildSeparator,
    );
  }

  /// Create a horizontal skeleton card
  @protected
  Widget buildItem(BuildContext context, int index) {
    return itemBuilder?.call(
          context,
          index,
        ) ??
        const SkeletonHorizontalCard(
          hasEffect: true,
        );
  }

  /// Create a separator between horizontal skeleton cards
  @protected
  Widget buildSeparator(BuildContext context, int index) {
    return separatorBuilder?.call(
          context,
          index,
        ) ??
        const SizedBox(height: 16);
  }
}
