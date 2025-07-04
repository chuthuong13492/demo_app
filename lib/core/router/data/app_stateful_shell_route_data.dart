import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/pages/app_transition_page.dart';
import '../redirect/app_redirect.dart';

abstract class AppStatefulShellRouteData implements StatefulShellRouteData {
  const AppStatefulShellRouteData();

  List<AppRedirect> get redirects => [];

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell);

  @override
  Page<void> pageBuilder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return AppTransitionPage(
      key: state.pageKey,
      name: state.name,
      type: AppTransitionType.noTransition,
      child: builder(context, state, navigationShell),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    if (redirects.isNotEmpty) {
      return AppRedirect.check(
        context,
        state,
        list: redirects,
      );
    }

    return null;
  }
}
