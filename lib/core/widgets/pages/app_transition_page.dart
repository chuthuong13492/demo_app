import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppTransitionType {
  noTransition,
  bottomToTop,
  topToBottom,
  rightToLeft,
  leftToRight,
}

class AppTransitionPage extends CustomTransitionPage {
  factory AppTransitionPage({
    LocalKey? key,
    String? name,
    required Widget child,
    AppTransitionType type = AppTransitionType.noTransition,
  }) {
    late Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) transitionsBuilder;

    Duration transitionDuration = const Duration(milliseconds: 300);
    Duration reverseTransitionDuration = const Duration(milliseconds: 300);

    switch (type) {
      case AppTransitionType.noTransition:
        transitionsBuilder = (context, animation, secondaryAnimation, child) {
          return child;
        };
        transitionDuration = Duration.zero;
        reverseTransitionDuration = Duration.zero;
      case AppTransitionType.bottomToTop:
        transitionsBuilder = (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        };
      case AppTransitionType.topToBottom:
        transitionsBuilder = (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        };
      case AppTransitionType.rightToLeft:
        transitionsBuilder = (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        };
      case AppTransitionType.leftToRight:
        transitionsBuilder = (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        };
    }

    return AppTransitionPage._(
      key: key,
      name: name,
      type: type,
      child: child,
      transitionsBuilder: transitionsBuilder,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
    );
  }
  const AppTransitionPage._({
    required super.key,
    required super.name,
    required AppTransitionType type,
    required super.child,
    required super.transitionsBuilder,
    required super.transitionDuration,
    required super.reverseTransitionDuration,
  });
}
