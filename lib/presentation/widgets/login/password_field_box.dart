import 'package:flutter/material.dart';

class PasswordFieldBox extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? errorText;
  const PasswordFieldBox(
      {super.key, required this.controller, this.onChanged, this.errorText});

  @override
  State<PasswordFieldBox> createState() => _PasswordFieldBoxState();
}

class _PasswordFieldBoxState extends State<PasswordFieldBox> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      prefixIcon: Icon(
        Icons.password_outlined,
        color: Colors.white70,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1.0)),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1.0)),
      label: Text('Password'),
      labelStyle: TextStyle(color: Colors.white70),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 1.0)),
      errorStyle: TextStyle(
          color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 13),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.yellow, width: 1.0)),
      errorText: widget.errorText,
      suffixIcon: IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Colors.white54,
        ),
        onPressed: () {
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
      ),
    );

    return TextFormField(
      controller: widget.controller,
      obscureText: !_passwordVisible,
      autocorrect: false,
      enableSuggestions: false,
      cursorColor: Colors.white70,
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Colors.white),
      decoration: inputDecoration,
      onChanged: widget.onChanged,
    );
  }
}
