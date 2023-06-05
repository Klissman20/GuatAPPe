import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';
import 'package:guatappe/presentation/providers/auth_repository_provider.dart';
import 'package:guatappe/presentation/providers/user_repository_provider.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import 'package:guatappe/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/config/theme/app_theme.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorApp = AppTheme.colorApp;

    return Scaffold(
      body: _RegisterView(),
      backgroundColor: colorApp,
    );
  }
}

class _RegisterView extends ConsumerStatefulWidget {
  const _RegisterView();

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<_RegisterView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerGender = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  String inputName = '';
  String inputLastname = '';
  String inputEmail = '';
  String inputGender = '';
  int inputPhone = 0;
  String inputCountry = '';
  String inputPassword = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerName.dispose();
    controllerLastName.dispose();
    controllerEmail.dispose();
    controllerGender.dispose();
    controllerPhone.dispose();
    controllerCountry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyleBtn = TextStyle(
        color: AppTheme.colorApp, fontSize: 22, fontWeight: FontWeight.bold);

    return Center(
      child: SafeArea(
          child: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppTheme.colorApp,
          expandedHeight: 145,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              'assets/logo/logo_guatappe.png',
              height: 130,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
            child: Column(children: [
              TextFieldBox(
                controller: controllerName,
                typeText: 'Name',
                onChanged: (value) {
                  setState(() {
                    inputName = controllerName.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // Probando validacion
              TextField(
                style: TextStyle(color: Colors.white),
                controller: controllerLastName,
                decoration: InputDecoration(
                    labelText: 'LastName',
                    errorStyle: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(246, 243, 193, 11)),
                    errorText: controllerLastName.value.text.isEmpty
                        ? 'No puede estar vacio' //Mensaje error
                        : null,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.black.withOpacity(0.1),
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white)),
                onChanged: (value) {
                  setState(() {
                    inputLastname = controllerLastName.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                controller: controllerEmail,
                typeText: 'Email',
                onChanged: (value) {
                  setState(() {
                    inputEmail = controllerEmail.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                controller: controllerGender,
                typeText: 'Gender',
                onChanged: (value) {
                  setState(() {
                    inputGender = controllerGender.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                controller: controllerPhone,
                typeText: 'Phone Number',
                onChanged: (value) {
                  setState(() {
                    inputPhone = int.parse(controllerPhone.text);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldBox(
                controller: controllerCountry,
                typeText: 'Country',
                onChanged: (value) {
                  setState(() {
                    inputCountry = controllerCountry.text;
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
              _RegisterButton(
                textStyleBtn: textStyleBtn,
                name: inputName,
                lastName: inputLastname,
                gender: inputGender,
                phone: inputPhone,
                password: inputPassword,
                email: inputEmail,
                country: inputCountry,
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          )
        ]))
      ])),
    );
  }
}

class _RegisterButton extends ConsumerWidget {
  final String name;
  final String lastName;
  final String email;
  final String gender;
  final String country;
  final int phone;
  final String password;

  const _RegisterButton({
    required this.textStyleBtn,
    required this.name,
    required this.password,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.country,
    required this.phone,
  });

  final TextStyle textStyleBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.transparent)))),
        child: Text(
          'Registrarse',
          style: textStyleBtn,
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          final response = await ref
              .read(authRepositoryProvider)
              .signUp(email: email, password: password);
          if (response['state'] == 'ok') {
            final newUser = UserModel(
                id: response['uid'],
                name: name,
                lastName: lastName,
                email: email,
                gender: gender,
                country: country,
                phone: phone);
            await ref.read(userRepositoryProvider).createUser(newUser);
            return await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: const Text('Grandioso!'),
                      content: Text('El usuario ha sido creado con exito'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              ctx.goNamed(LoginScreen.name);
                            },
                            child: const Text("Iniciar Sesion"))
                      ],
                    ));
          }
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
                    child: const Text("Aceptar"))
              ],
            ),
          );
        },
      ),
    );
  }
}

String removeFirstWord(String input) {
  List<String> words = input.split(' ');
  if (words.length <= 1) {
    return '';
  }
  words.removeAt(0);
  return words.join(' ');
}
