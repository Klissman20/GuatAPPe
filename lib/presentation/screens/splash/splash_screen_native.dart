import 'package:flutter/material.dart';
import 'package:guatappe/presentation/screens/login/login_screen.dart';

class SplashScreenNative extends StatefulWidget {
  const SplashScreenNative({super.key});

  @override
  State<SplashScreenNative> createState() => _SplashState();
}

class _SplashState extends State<SplashScreenNative> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color.fromARGB(0xFF, 0xDB, 0x41, 0x1F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/logo_guatappe.png',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
