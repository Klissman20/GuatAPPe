import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/presentation/providers/auth_provider.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import '../../../config/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class SplashScreenAnimated extends ConsumerWidget {
  static const String name = 'splash_screen_animated';
  const SplashScreenAnimated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider) != null;
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/logo/logo_animado1.json'),
        nextScreen: authState ? MapScreen() : LoginScreen(),
        splashTransition: SplashTransition.scaleTransition,
        nextRoute: authState ? MapScreen.name : LoginScreen.name,
        backgroundColor: AppTheme.colorApp,
        splashIconSize: 300.0);
  }
}
