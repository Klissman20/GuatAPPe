import 'package:flutter/material.dart';
import 'package:guatappe/presentation/providers/login_provider.dart';
import 'package:guatappe/presentation/screens/splash/splash_screen_animated.dart';
import 'package:provider/provider.dart';
import 'config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        title: 'Guatappé',
        home: const SplashScreenAnimated(),
      ),
    );
  }
}
