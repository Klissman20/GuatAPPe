import 'package:flutter/material.dart';

class UserFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const UserFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    const TextStyle textStyle = TextStyle(color: Colors.white54, fontSize: 18);

    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
        hintText: 'E-mail',
        hintStyle: textStyle,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        focusedErrorBorder: InputBorder.none);

    return TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        cursorColor: Colors.white54,
        keyboardAppearance: Brightness.light,
        keyboardType: TextInputType.emailAddress,
        style: textStyle,
        controller: textController,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {
          onValue(value);
        });
  }
}
