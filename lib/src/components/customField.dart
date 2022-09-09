import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String labelText;

  const CustomField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.deepPurple),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))),
    );
  }
}
