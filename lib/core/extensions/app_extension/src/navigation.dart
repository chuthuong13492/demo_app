part of '../app_extension.dart';

// ignore: library_private_types_in_public_api
extension NavigatorExt on _AppExt {
  /// Tìm context hiện tại
  BuildContext get context => AppRouter.rootNavigatorKey.currentContext!;

  GoRouter get router => AppRouter.router;

  void go(
    String location, {
    Object? extra,
  }) =>
      router.go(
        location,
        extra: extra,
      );

  void pop<T>([T? result]) => router.pop(result);

  Future<T?> push<T>(Widget Function(BuildContext context) builder) =>
      Navigator.of(context).push<T>(MaterialPageRoute(builder: builder));
}
