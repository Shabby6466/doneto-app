import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    // initialLocation: Routes.splash,
    routes:[],
    // observers: [NavigationObserver()],
    // errorBuilder: (context, state) => Routes.errorWidget(context, state),
  );

  static GoRouter get router => _router;
}
