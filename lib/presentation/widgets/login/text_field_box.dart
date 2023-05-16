import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  final String typeText;
  const TextFieldBox({super.key, required this.typeText});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.white54, fontSize: 18);

    final outlineInputBorder = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(20));

    final inputDecoration = InputDecoration(
        labelText: typeText,
        labelStyle: TextStyle(color: Colors.white54),
        hintText: 'Enter your $typeText',
        hintStyle: textStyle,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        focusedErrorBorder: InputBorder.none);

    return TextFormField(
        autocorrect: false,
        enableSuggestions: false,
        cursorColor: Colors.white54,
        keyboardAppearance: Brightness.light,
        keyboardType: (typeText == 'Email')
            ? TextInputType.emailAddress
            : (typeText == 'Phone Number')
                ? TextInputType.number
                : TextInputType.text,
        style: textStyle,
        decoration: inputDecoration,
        onFieldSubmitted: (value) {});
  }
}
