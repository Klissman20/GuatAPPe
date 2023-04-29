import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../../config/theme/app_theme.dart';
import '../login/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenAnimated extends StatelessWidget {
  const SplashScreenAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/logo/logo_animado1.json'),
        nextScreen: const LoginScreen(),
        backgroundColor: AppTheme.colorApp,
        splashIconSize: 300.0);
  }
}
