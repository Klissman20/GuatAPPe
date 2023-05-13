import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/login/password_field_box.dart';
import '../../widgets/login/user_field_box.dart';
import '../../screens/screens.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login_screen';

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
          UserFieldBox(onValue: (value) => {}),
          const SizedBox(
            height: 20,
          ),
          PasswordFieldBox(onValue: (value) => {}),
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
      child: ElevatedButton(
          onPressed: () {
            context.goNamed(MapScreen.name);
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.transparent)))),
          child: Text(
            'Iniciar sesión',
            style: textStyleBtn,
          )),
    );
  }
}
