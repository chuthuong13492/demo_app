import 'package:flutter/material.dart';

import '../skeleton.dart' show Skeleton;

/// The widget for the skeleton horizontal card
class SkeletonHorizontalCard extends Skeleton {
  /// Create a skeleton horizontal card
  const SkeletonHorizontalCard({
    super.key,
    this.height = 60,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.child,
    super.hasEffect,
    this.color = const Color(0xFFFFFFFF),
  });

  /// The height of the skeleton horizontal card
  final double? height;

  /// The width of the skeleton horizontal card
  final double? width;

  /// The border radius of the skeleton horizontal card
  final BorderRadius borderRadius;

  /// The child of the skeleton horizontal card
  final Widget? child;

  /// The color of the skeleton horizontal card
  final Color color;

  @override
  Widget skeletonBuilder(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE5E5E5),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
