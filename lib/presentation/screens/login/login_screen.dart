import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/presentation/providers/auth_repository_provider.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/login/password_field_box.dart';
import '../../widgets/login/text_field_box.dart';
import '../../screens/screens.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String inputUser = '';
  String inputPassword = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerUser.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 22, fontWeight: FontWeight.bold);

    return Scaffold(
        body: Container(
            color: AppTheme.colorApp,
            child: SafeArea(
                child: Center(
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
                        controller: controllerUser,
                        typeText: 'Email',
                        onChanged: (value) {
                          setState(() {
                            inputUser = controllerUser.text;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordFieldBox(
                        controller: controllerPassword,
                        onChanged: (value) {
                          setState(() {
                            inputPassword = controllerPassword.text;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _LogInButton(
                        textStyleBtn: textStyleBtn,
                        user: inputUser,
                        password: inputPassword,
                      ),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(RegisterScreen.name);
                          },
                          child: Text(
                            '¿No tiene una cuenta? - Registrese',
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ))
                    ],
                  ),
                ),
              ),
            ))));
  }
}

class _LogInButton extends ConsumerWidget {
  final TextStyle textStyleBtn;
  final String user;
  final String password;
  const _LogInButton({
    required this.textStyleBtn,
    required this.user,
    required this.password,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            final response = await ref
                .read(authRepositoryProvider)
                .signIn(email: user, password: password);
            if (response['state'] == 'ok')
              return context.goNamed(MapScreen.name);
            await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Ups!'),
                content: Text(response['error'].toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("OK"))
                ],
              ),
            );
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
