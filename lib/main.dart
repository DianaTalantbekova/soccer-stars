import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/screens/navigation_screen.dart';
import 'package:soccer_stars/screens/screens.dart';

void main() {
  runZonedGuarded(() {
    runApp(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return MyApp();
        },
      ),
    );
  }, (error, stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final GoRouter _router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return NavigationScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              child: const QuizScreen(),
              context: context,
              state: state,
            ),
          ),
          GoRoute(
            path: '/store_screen',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              child: const StoreScreen(),
              context: context,
              state: state,
            ),
          ),
          GoRoute(
            path: '/collections_screen',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              child: const CollectionsScreen(),
              context: context,
              state: state,
            ),
          ),
          GoRoute(
            path: '/settings_screen',
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
              child: const SettingsScreen(),
              context: context,
              state: state,
            ),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      // routerDelegate: _router.routerDelegate,
      // routeInformationParser: _router.routeInformationParser,
      // routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
