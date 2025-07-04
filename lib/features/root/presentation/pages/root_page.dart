import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class _RootScope extends InheritedWidget {
  const _RootScope({
    required super.child,
    required this.navigationShell,
    required this.rootState,
  });

  final StatefulNavigationShell navigationShell;

  final RootPageState rootState;

  @override
  bool updateShouldNotify(covariant _RootScope oldWidget) => false;
}

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    required StatefulNavigationShell navigationShell,
  }) : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  State<RootPage> createState() => RootPageState();

  static RootPageState? maybeOf(BuildContext context) {
    final _RootScope? scope = context.dependOnInheritedWidgetOfExactType<_RootScope>();

    return scope?.rootState;
  }
}

class RootPageState extends State<RootPage> {
  final GlobalKey<ScaffoldState> _rootScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _RootScope(
      navigationShell: widget._navigationShell,
      rootState: this,
      child: Scaffold(
        key: _rootScaffoldKey,
        body: widget._navigationShell,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
