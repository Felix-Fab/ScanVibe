import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scanvibe/Pages/Start/Login/Login.dart';
import 'package:scanvibe/Pages/Start/Registration/Registration.dart';
import 'Firebase/firebase_controller.dart';
import 'Navigation/Navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseController.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    CustomTransitionPage routeAnimation<T>({
      required BuildContext context,
      required GoRouterState state,
      required Widget child,
    }) {
      return CustomTransitionPage<T>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    }

    final GoRouter router = GoRouter(
      initialLocation: auth.currentUser == null ? '/' : '/navigation',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => routeAnimation<void>(
              child: const LoginWidget(), context: context, state: state),
        ),
        GoRoute(
          path: '/registration',
          pageBuilder: (context, state) => routeAnimation<void>(
              child: const RegistrationWidget(), context: context, state: state),
        ),
        GoRoute(
          path: '/navigation',
          pageBuilder: (context, state) => routeAnimation<void>(
              child: const Navigation(), context: context, state: state),
        )
      ],
    );

    return MaterialApp.router(
      title: 'ScnVibe',
      routerConfig: router,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xfff6fff7)),
    );
  }
}