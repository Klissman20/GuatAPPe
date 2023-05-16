import 'package:flutter/material.dart';
import 'package:guatappe/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/app_theme.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorApp = AppTheme.colorApp;

    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: _RegisterView(),
        backgroundColor: colorApp,);
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 22, fontWeight: FontWeight.bold);
    return Center(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'assets/logo/logo_guatappe.png',
                  height: 100,
                ),
              ),
              TextFieldBox(
                typeText: 'Username',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                typeText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                typeText: 'Gender',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                typeText: 'Phone Number',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                typeText: 'Country',
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordFieldBox(),
              const SizedBox(
                height: 20,
              ),
              _RegisterButton(textStyleBtn: textStyleBtn),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    required this.textStyleBtn,
  });

  final TextStyle textStyleBtn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.transparent)))),
          child: Text(
            'Registrarse',
            style: textStyleBtn,
          )),
    );
  }
}
