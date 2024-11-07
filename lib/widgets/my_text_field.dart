import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.errorText,
    this.inputType,
    required this.readOnly,
  });
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? inputType;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        readOnly: readOnly,
        keyboardType: inputType,
        obscureText: obscureText,
        cursorColor: Colors.grey.shade600,
        controller: controller,
        decoration: InputDecoration(
          errorText: errorText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
          ),
          border: const UnderlineInputBorder(),
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
