import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_redirect.dart';

class InitialRedirect extends AppRedirect {
  InitialRedirect({
    required super.priority,
    required this.initialLocation,
  });

  final String initialLocation;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (['', '/'].contains(state.uri.path)) return initialLocation;

    return null;
  }
}
