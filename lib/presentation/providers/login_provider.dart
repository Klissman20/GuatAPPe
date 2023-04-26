import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  Future<void> onLoginButton(String text) async {
    await Future.delayed(const Duration(seconds: 2));
    print(text);
  }
}
