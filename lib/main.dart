import 'package:demo_app/core/extensions/app_extension/app_extension.dart';
import 'package:demo_app/core/observers/app_bloc_observer.dart';
import 'package:demo_app/core/observers/app_router_observer.dart';
import 'package:demo_app/core/router/app_router.dart';
import 'package:demo_app/routes/route.dart';
import 'package:demo_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const _App());
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => __AppState();
}

class __AppState extends State<_App> {
  @override
  void initState() {
    super.initState();

    Repository.initialize();

    // app router
    AppRouter.initialize(
      initialLocation: RootRoute.initialLocation,
      observers: [
        AppRouterObserver(),
      ],
    );

    // bloc observer
    Bloc.observer = AppBlocObserver();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: App.router.routeInformationProvider,
      routeInformationParser: App.router.routeInformationParser,
      routerDelegate: App.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: GestureDetector(
            onTap: App.unfocus,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
