import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/screens/premium_screen.dart';
import 'package:soccer_stars/screens/quiz_screen.dart';

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

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        routes: [
          GoRoute(
            path: 'quiz_screen',
            builder: (BuildContext context, GoRouterState state) =>
                const QuizScreen(),
          ),
        ],
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const PremiumScreen(),
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
