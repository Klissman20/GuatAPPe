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
    pageBuilder: (context, state) => _transitionPage(state),
  ),
  GoRoute(
      name: RegisterScreen.name,
      path: '/register',
      builder: (context, state) => const RegisterScreen()),
  GoRoute(
      name: VideoScreen.name,
      path: '/video',
      builder: (context, state) => const VideoScreen(),
      pageBuilder: (context, state) => _transitionPage(state),
  ),
  
  GoRoute(
    name: MapScreen.name,
    path: '/map',
    builder: (context, state) => const MapScreen(),
    pageBuilder: (context, state) => _transitionPage(state),
  ),
]);


CustomTransitionPage<dynamic> _transitionPage(GoRouterState state) {
  return CustomTransitionPage(
      key: state.pageKey,
      child: const LoginScreen(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}
