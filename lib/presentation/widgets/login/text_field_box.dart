import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.onChanged,
    required this.prefixIcon,
    required this.typeText,
    this.readOnly,
    this.errorText,
  });

  final TextEditingController controller;
  final String labelText;
  final void Function() onChanged;
  final IconData prefixIcon;
  final TextInputType typeText;
  final String? errorText;
  final bool? readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.typeText,
        cursorColor: Colors.white70,
        style: TextStyle(color: Colors.white),
        controller: widget.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              widget.prefixIcon,
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
            label: Text(widget.labelText),
            labelStyle: TextStyle(color: Colors.white70),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white70, width: 1.0)),
            errorStyle: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 13),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow, width: 1.0)),
            errorText: widget.errorText),
        onChanged: (_) {
          widget.onChanged();
        });
  }
}
