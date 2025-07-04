// Importing required packages and libraries
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' show Animate, ShimmerEffect;

// Exporting skeleton components
export 'src/skeleton_container.dart' show SkeletonContainer;
export 'src/skeleton_horizontal_card.dart' show SkeletonHorizontalCard;
export 'src/skeleton_horizontal_card_list.dart' show SkeletonHorizontalCardList;
export 'src/skeleton_line.dart' show SkeletonLine;
export 'src/skeleton_paragraph.dart' show SkeletonParagraph;

/// Abstract class Skeleton which extends StatelessWidget
///
/// This class provides a base for creating skeleton loading screens
abstract class Skeleton extends StatelessWidget {
  /// Constructor for the Skeleton class
  ///
  /// Allows customization of whether the skeleton has an effect or not
  const Skeleton({
    super.key,
    this.hasEffect = true,
  });

  /// Default colors for the skeleton
  static const Color color = Color(0xFFF5F5F5);

  /// Default focus color for the skeleton
  static const Color focusColor = Color(0xFFE6E6E6);

  /// Flag to determine if the skeleton has an effect
  final bool hasEffect;

  /// Function to generate a random double within a range
  double randomInRange(num start, num end) => Random().nextDouble() * (end - start) + start;

  @override
  Widget build(BuildContext context) {
    // Building the skeleton
    Widget child = skeletonBuilder(context);
    // If the skeleton has an effect, apply the ShimmerEffect
    if (hasEffect) {
      child = Animate(
        effects: const [
          ShimmerEffect(
            delay: Duration(milliseconds: 300),
            duration: Duration(seconds: 1),
            color: Color(0xFFFFFFFF),
          ),
        ],
        onComplete: (controller) {
          controller.forward(from: 0);
        },
        child: child,
      );
    }
    return child;
  }

  /// create a skeleton widget
  Widget skeletonBuilder(BuildContext context);
}
