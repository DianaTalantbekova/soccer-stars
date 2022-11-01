import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soccer_stars/blocs/quiz_bloc/quiz_bloc.dart';
import 'package:soccer_stars/screens/screens.dart';
import 'package:soccer_stars/services/preference_service.dart';
import 'package:soccer_stars/utils/players.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceService().init();

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
          final selected = state.location == "/settings_screen" ? 3 : null;
          return NavigationScreen(
            selected: selected,
            child: child,
          );
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
      GoRoute(
        path: '/premium_screen',
        builder: (context, state) => const PremiumScreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PreferenceService>(
      create: (context) => PreferenceService(),
      child: BlocProvider<QuizBloc>(
        create: (context) =>
            QuizBloc(RepositoryProvider.of(context))..add(InitQuizEvent()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
        ),
      ),
    );
  }

  void cacheImage(BuildContext context) async {
    for (final item in players) {
      precacheImage(Image.asset(item.asset).image, context);
      await Future.delayed(const Duration(microseconds: 50));
    }
  }
}
