import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';
import 'package:guatappe/presentation/providers/auth_repository_provider.dart';
import 'package:guatappe/presentation/providers/user_repository_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/login/password_field_box.dart';
import '../../widgets/login/text_field_box.dart';
import '../../screens/screens.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
                      CustomTextField(
                        controller: controllerUser,
                        typeText: TextInputType.name,
                        onChanged: () {
                          setState(() {
                            inputUser = controllerUser.text;
                          });
                        },
                        labelText: 'Email',
                        prefixIcon: Icons.person_outlined,
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => PasswordScreen());
                            },
                            child: Text(
                              '¿Olvidó su contraseña?',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            )),
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
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 17),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Accede con:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          _GoogleButton(),
                          SizedBox(width: 20),
                          _AppleButton(),
                        ],
                      ),
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
                content: Text(removeFirstWord(response['error'].toString())),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Ok"))
                ],
              ),
            );
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.transparent)))),
          child: Text(
            'Iniciar sesión',
            style: textStyleBtn,
          )),
    );
  }
}

class _GoogleButton extends ConsumerWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 18, fontWeight: FontWeight.bold);

    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.transparent)))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Google',
              style: textStyleBtn,
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/google-logo.png',
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          final response =
              await ref.read(authRepositoryProvider).continueWithGoogle();
          final GoogleSignInAccount googleUser = response['user'];
          final newUser = UserModel(
              id: response['uid'],
              name: googleUser.displayName.toString(),
              lastName: '',
              email: googleUser.email,
              gender: '',
              country: '',
              phone: 0);
          await ref.read(userRepositoryProvider).createUser(newUser);
          if (response['state'] == 'ok') return context.goNamed(MapScreen.name);
        },
      ),
    );
  }
}

class _AppleButton extends ConsumerWidget {
  const _AppleButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 18, fontWeight: FontWeight.bold);

    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.transparent)))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Apple',
              style: textStyleBtn,
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                'assets/apple-logo.png',
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          final response =
              await ref.read(authRepositoryProvider).continueWithApple();

          final AuthorizationCredentialAppleID appleUser = response['user'];
          if (appleUser.givenName != null) {
            final newUser = UserModel(
                id: response['uid'],
                name: appleUser.givenName!,
                lastName: appleUser.familyName!,
                email: appleUser.email!,
                gender: '',
                country: '',
                phone: 0);
            await ref.read(userRepositoryProvider).createUser(newUser);
          }
          if (response['state'] == 'ok') return context.goNamed(MapScreen.name);
        },
      ),
    );
  }
}
