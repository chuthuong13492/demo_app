import 'package:flutter/material.dart';

import '../skeleton.dart' show Skeleton;

/// The widget for the skeleton container
class SkeletonContainer extends Skeleton {
  /// Create skeleton container
  const SkeletonContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.child,
    this.shape = BoxShape.rectangle,
    super.hasEffect,
    this.color,
  });

  /// The height of the skeleton container
  final double? height;

  /// The width of the skeleton container
  final double? width;

  /// The border radius of the skeleton container
  final BorderRadius borderRadius;

  /// The child widget of the skeleton container
  final Widget? child;

  /// The shape of the skeleton container
  final BoxShape shape;

  /// The color of the skeleton container
  final Color? color;

  @override
  Widget skeletonBuilder(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color ?? Skeleton.color,
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        shape: shape,
      ),
      child: child,
    );
  }
}
