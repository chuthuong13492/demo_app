import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/route.dart';
import '../observers/app_router_observer.dart';
import '../widgets/pages/error_page.dart';
import 'redirect/app_redirect.dart';
import 'redirect/initial_redirect.dart';

class AppRouter {
  AppRouter._() : super();

  static AppRouter? _instance;
  static AppRouter get instance {
    _instance ??= AppRouter._();
    return _instance!;
  }

  late final GoRouter _router;
  static GoRouter get router => instance._router;

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  static GlobalKey<NavigatorState> get rootNavigatorKey => instance._rootNavigatorKey;

  bool _hasInitialized = false;

  static void initialize({
    Listenable? refreshListenable,
    List<NavigatorObserver>? observers,
    required String initialLocation,
  }) {
    if (!instance._hasInitialized) {
      instance._hasInitialized = true;
      instance._router = GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: initialLocation,
        refreshListenable: refreshListenable,
        observers: observers ??
            [
              AppRouterObserver(),
            ],
        errorBuilder: (context, state) {
          return ErrorPage(
            state: state,
          );
        },
        redirect: (context, state) async {
          final String? location = await AppRedirect.check(
            context,
            state,
            list: [
              InitialRedirect(priority: 1, initialLocation: initialLocation),
            ],
          );

          return location;
        },
        routes: $appRoutes,
      );
    }
  }
}
