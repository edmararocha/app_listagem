import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final TextInputType type;

  const CustomField({super.key, required this.labelText, required this.type});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      cursorColor: Colors.deepPurple,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.deepPurple),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple,
            ),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
