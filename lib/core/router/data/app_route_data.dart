import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/pages/app_transition_page.dart';

@immutable
abstract class AppRouteData implements GoRouteData {
  const AppRouteData();

  AppTransitionType get transitionType => AppTransitionType.rightToLeft;

  @override
  Widget build(BuildContext context, GoRouterState state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (transitionType == AppTransitionType.rightToLeft) {
      return CupertinoPage(
        key: state.pageKey,
        name: state.name,
        child: build(context, state),
      );
    }

    return AppTransitionPage(
      key: state.pageKey,
      name: state.name,
      type: transitionType,
      child: build(context, state),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return null;
  }

  @override
  FutureOr<bool> onExit(BuildContext context, GoRouterState state) {
    return true;
  }
}
