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
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      builder: (context, state) => const RegisterScreen()),
  GoRoute(
    name: MapScreen.name,
    path: '/map',
    builder: (context, state) => const MapScreen(),
    //pageBuilder: (context, state) => _transitionPage(state),
  ),
]);
