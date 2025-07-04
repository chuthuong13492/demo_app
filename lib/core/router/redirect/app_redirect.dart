import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRedirect {
  AppRedirect({
    required this.priority,
  });

  final int priority;

  FutureOr<String?> redirect(BuildContext context, GoRouterState state);

  bool isRoute(GoRouterState state, String url) {
    return url.matchAsPrefix(state.uri.toString()) != null;
  }

  static String? _location;

  static FutureOr<String?> check(
    BuildContext context,
    GoRouterState state, {
    required List<AppRedirect> list,
  }) async {
    if (_location == state.uri.toString()) return null;

    list.sort((a, b) => a.priority.compareTo(b.priority));

    for (final appRedirect in list) {
      final location = await appRedirect.redirect(context, state);
      if (location != null) return location;
    }

    return null;
  }
}
