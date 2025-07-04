import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

import '../extensions/app_extension/app_extension.dart';

class AppRouterObserver extends NavigatorObserver {
  AppRouterObserver();

  final Talker talker = debugTalker;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logCustom(_TalkerRouteLog(route: route));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logCustom(_TalkerRouteLog(route: route, isPush: false));
  }
}

class _TalkerRouteLog extends TalkerLog {
  _TalkerRouteLog({
    required Route route,
    bool isPush = true,
  }) : super(_createMessage(route, isPush));

  @override
  AnsiPen get pen => AnsiPen()..xterm(135);

  @override
  String get key => TalkerLogType.route.key;

  static String _createMessage(
    Route<dynamic> route,
    bool isPush,
  ) {
    final buffer = StringBuffer();
    buffer.write(isPush ? 'Open' : 'Close');
    buffer.write(' route named ');
    buffer.write(route.settings.name ?? 'null');

    final args = route.settings.arguments;
    if (args != null) {
      buffer.write('\nArguments: $args');
    }
    return buffer.toString();
  }
}
