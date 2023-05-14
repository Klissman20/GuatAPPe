import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/login/password_field_box.dart';
import '../../widgets/login/text_field_box.dart';
import '../../screens/screens.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

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
        color: AppTheme.colorApp, fontSize: 22, fontWeight: FontWeight.bold);

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SingleChildScrollView(
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
            TextFieldBox(
              typeText: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordFieldBox(),
            const SizedBox(
              height: 20,
            ),
            _LogInButton(textStyleBtn: textStyleBtn),
            TextButton(
                onPressed: () {
                  context.pushNamed(RegisterScreen.name);
                },
                child: Text(
                  'No tiene una cuenta? - Registrese',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    ));
  }
}

class _LogInButton extends StatelessWidget {
  final TextStyle textStyleBtn;

  const _LogInButton({
    required this.textStyleBtn,
  });

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
