import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../../config/theme/app_theme.dart';
import '../login/login_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenAnimated extends StatelessWidget {
  const SplashScreenAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Image.asset('assets/logo/logo_guatappe.png'),
        nextScreen: const LoginScreen(),
        duration: 3000,
        backgroundColor: AppTheme.colorApp,
        splashIconSize: 200.0,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade);
  }
}
