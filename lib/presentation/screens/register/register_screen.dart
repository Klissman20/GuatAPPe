import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
        leading: BackButton(
          color: Colors.deepOrange,
          onPressed: () {
            context.goNamed('map_screen');
          },
        ),
      ),
      body: const Center(
        child: Text('UnityWidget'),
      ),
    );
  }
}
