import 'package:flutter/material.dart';

class PasswordFieldBox extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const PasswordFieldBox({super.key, required this.controller, this.onChanged});

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
    const TextStyle textStyle = TextStyle(color: Colors.white54, fontSize: 18);

    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
      labelText: 'Password',
      labelStyle: TextStyle(color: Colors.white54),
      hintText: 'Enter your password',
      hintStyle: textStyle,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      focusedErrorBorder: InputBorder.none,
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
      cursorColor: Colors.white54,
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      style: textStyle,
      decoration: inputDecoration,
      onChanged: widget.onChanged,
    );
  }
}
