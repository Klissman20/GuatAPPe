import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/app_theme.dart';
import '../../providers/login_provider.dart';
import '../../widgets/login/password_field_box.dart';
import '../../widgets/login/user_field_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppTheme.colorApp,
      child: _LoginView(),
    ));
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 24, fontWeight: FontWeight.bold);

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Image.asset(
              'assets/logo/logo_guatappe.png',
              height: 150,
            ),
          ),
          UserFieldBox(
              onValue: (value) => {loginProvider.onLoginButton(value)}),
          const SizedBox(
            height: 20,
          ),
          PasswordFieldBox(
              onValue: (value) => {loginProvider.onLoginButton(value)}),
          const SizedBox(
            height: 20,
          ),
          LogInButton(textStyleBtn: textStyleBtn)
        ],
      ),
    ));
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
    required this.textStyleBtn,
  });

  final TextStyle textStyleBtn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Expanded(
          child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: Colors.transparent)))),
              child: Text(
                'Iniciar sesión',
                style: textStyleBtn,
              ))),
    );
  }
}
