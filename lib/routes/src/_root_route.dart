part of '../route.dart';

@TypedStatefulShellRoute<RootRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        _homeRoute,
      ],
    ),
  ],
)
class RootRoute extends AppStatefulShellRouteData {
  const RootRoute();

  static String get initialLocation => const HomeRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return RootPage(navigationShell: navigationShell);
  }
}

extension RootRouteExtension on RootRoute {
  void go(BuildContext context) => context.go(RootRoute.initialLocation);
}
