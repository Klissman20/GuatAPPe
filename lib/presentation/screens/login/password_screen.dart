import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/config/theme/app_theme.dart';
import 'package:guatappe/presentation/providers/firebase_provider.dart';
import 'package:guatappe/presentation/widgets/widgets.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  static const String name = 'password_screen';

  const PasswordScreen({super.key});

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  String mensaje = '';
  TextEditingController controllerUser = TextEditingController();

  String? errorTextEmail(String text) {
    if (text.isEmpty) return 'Can\'t be empty';
    return !text.contains('@') || !text.contains('.')
        ? 'Enter a valid email'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.colorApp,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text('Recuperar contraseña',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        CustomTextField(
          readOnly: mensaje != '',
          controller: controllerUser,
          typeText: TextInputType.emailAddress,
          onChanged: () {
            setState(() {});
          },
          labelText: 'Email',
          prefixIcon: Icons.email_outlined,
          errorText: errorTextEmail(controllerUser.value.text),
        ),
        mensaje == ''
            ? SizedBox(height: 10)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mensaje,
                  style: TextStyle(color: Colors.white),
                ),
              ),
        ElevatedButton(
            onPressed: mensaje != '' ||
                    errorTextEmail(controllerUser.value.text) != null
                ? null
                : () async {
                    try {
                      await ref
                          .read(firebaseAuthProvider)
                          .sendPasswordResetEmail(
                              email: controllerUser.text.trim());
                      setState(() {
                        mensaje = 'Correo enviado con exito';
                      });
                    } on FirebaseAuthException catch (e) {
                      debugPrint('Este es el error:');
                      debugPrint(e.toString());
                      setState(() {
                        mensaje = removeFirstWord(e.toString());
                      });
                      return;
                    }
                  },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: const BorderSide(color: Colors.transparent)))),
            child: Text(
              'Enviar',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
      ]),
    );
  }

  String removeFirstWord(String input) {
    List<String> words = input.split(' ');
    if (words.length <= 1) {
      return '';
    }
    words.removeAt(0);
    return words.join(' ');
  }
}
