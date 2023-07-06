import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      name: SplashScreenAnimated.name,
      path: '/',
      builder: (context, state) => const SplashScreenAnimated()),
  GoRoute(
      name: LoginScreen.name,
      path: '/login',
      pageBuilder: (context, state) =>
          transitionPage(state, const LoginScreen())),
  GoRoute(
      name: PasswordScreen.name,
      path: '/password',
      pageBuilder: (context, state) =>
          transitionPage(state, const PasswordScreen())),
  GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      pageBuilder: (context, state) =>
          transitionPage(state, const RegisterScreen())),
  GoRoute(
      name: MapScreen.name,
      path: '/map',
      pageBuilder: (context, state) =>
          transitionPage(state, const MapScreen())),
]);

CustomTransitionPage<MaterialPage> transitionPage(
    GoRouterState state, Widget screen) {
  return CustomTransitionPage(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 200),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child));
}
