import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guatappe/domain/entities/user_entity.dart';
import 'package:guatappe/infrastructure/models/user_model.dart';
import 'package:guatappe/presentation/providers/auth_repository_provider.dart';
import 'package:guatappe/presentation/providers/user_repository_provider.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import 'package:guatappe/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/config/theme/app_theme.dart';

String inputName = '';
String inputLastname = '';
String inputEmail = '';
String inputGender = '';
int inputPhone = 0;
String inputCountry = '';
String inputPassword = '';

String? errorTextName(String text) {
  if (text.isEmpty) {
    return 'Can\'t be empty';
  }
  // return null if the text is valid
  return null;
}

String? errorTextEmail(String text) {
  if (text.isEmpty) return 'Can\'t be empty';

  if (!text.contains('@') || !text.contains('.')) return 'Enter a valid email';
  // return null if the text is valid
  return null;
}

String? errorTextPhone(String text) {
  if (text.isEmpty) return 'Can\'t be empty';

  if (text.length < 10) return 'Enter a valid phone';
  // return null if the text is valid
  return null;
}

String? errorTextPassword(String text) {
  if (text.isEmpty) return 'Can\'t be empty';

  if (text.length < 8) return 'Too short';
  // return null if the text is valid
  return null;
}

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';
  final UserEntity? user;

  const RegisterScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final colorApp = AppTheme.colorApp;

    return Scaffold(
      body: _RegisterView(user),
      backgroundColor: colorApp,
    );
  }
}

class _RegisterView extends ConsumerStatefulWidget {
  final UserEntity? user;
  _RegisterView(this.user);

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
  void initState() {
    controllerName.text = widget.user?.name ?? '';
    controllerLastName.text = widget.user?.lastName ?? '';
    controllerEmail.text = widget.user?.email ?? '';
    inputEmail = controllerEmail.text;
    controllerGender.text = widget.user?.gender ?? '';
    controllerPhone.text = widget.user?.phone.toString() ?? '';
    controllerCountry.text = widget.user?.country ?? '';
    super.initState();
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
              CustomTextField(
                errorText: errorTextName(controllerName.value.text),
                typeText: TextInputType.name,
                prefixIcon: Icons.person_3_outlined,
                controller: controllerName,
                labelText: 'Name',
                onChanged: () {
                  setState(() {
                    inputName = controllerName.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // Probando validacion
              CustomTextField(
                errorText: errorTextName(controllerLastName.value.text),
                typeText: TextInputType.name,
                prefixIcon: Icons.person_4_outlined,
                controller: controllerLastName,
                labelText: 'LastName',
                onChanged: () {
                  setState(() {
                    inputLastname = controllerLastName.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                readOnly: widget.user?.id != null,
                errorText: errorTextEmail(controllerEmail.value.text),
                typeText: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                controller: controllerEmail,
                labelText: 'Email',
                onChanged: () {
                  setState(() {
                    inputEmail = controllerEmail.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                errorText: errorTextName(controllerGender.value.text),
                typeText: TextInputType.name,
                prefixIcon: Icons.person_search_outlined,
                controller: controllerGender,
                labelText: 'Gender',
                onChanged: () {
                  setState(() {
                    inputGender = controllerGender.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                errorText: errorTextPhone(controllerPhone.value.text),
                typeText: TextInputType.phone,
                prefixIcon: Icons.phone_enabled_outlined,
                controller: controllerPhone,
                labelText: 'Phone',
                onChanged: () {
                  setState(() {
                    inputPhone = controllerPhone.text.isNotEmpty
                        ? int.parse(controllerPhone.text)
                        : 0;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                errorText: controllerCountry.value.text.isEmpty
                    ? "Can't be empty"
                    : null,
                typeText: TextInputType.name,
                prefixIcon: Icons.location_city_outlined,
                controller: controllerCountry,
                labelText: 'Country',
                onChanged: () {
                  setState(() {
                    inputCountry = controllerCountry.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),

              widget.user?.id == null
                  ? PasswordFieldBox(
                      errorText:
                          errorTextPassword(controllerPassword.value.text),
                      controller: controllerPassword,
                      onChanged: (value) {
                        setState(() {
                          inputPassword = controllerPassword.text;
                        });
                      },
                    )
                  : SizedBox(),
              const SizedBox(
                height: 20,
              ),
              _RegisterButton(
                textStyleBtn: textStyleBtn,
                name: inputName,
                id: widget.user?.id,
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
  final String? id;
  final String name;
  final String lastName;
  final String email;
  final String gender;
  final String country;
  final int phone;
  final String password;

  _RegisterButton({
    required this.textStyleBtn,
    this.id,
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
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.transparent)))),
        child: Text(
          id == null ? 'Registrarse' : 'Actualizar',
          style: textStyleBtn,
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          final response = id == null
              ? await ref
                  .read(authRepositoryProvider)
                  .signUp(email: email, password: password)
              : {'uid': id, 'state': 'ok'};
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
                      content: Text(
                          'El usuario ha sido ${id == null ? 'creado' : 'guardado'} con exito'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              if (id == null) ctx.goNamed(LoginScreen.name);
                            },
                            child:
                                Text(id == null ? "Iniciar Sesion" : "Aceptar"))
                      ],
                    ));
          }
          return await showDialog(
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
