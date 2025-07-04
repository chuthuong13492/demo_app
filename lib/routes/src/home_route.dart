part of '../route.dart';

const TypedGoRoute _homeRoute = TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<DetailRoute>(
      path: ':url',
    ),
  ],
);

class HomeRoute extends AppRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class DetailRoute extends AppRouteData {
  const DetailRoute(this.url);

  final String url;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailPage(url: url);
  }
}
