import 'package:flutter/material.dart';
import 'package:guatappe/presentation/screens/splash_screen.dart';
import 'config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().getTheme(),
      title: 'Guatappé',
      home: const SplashScreen(),
    );
  }
}
