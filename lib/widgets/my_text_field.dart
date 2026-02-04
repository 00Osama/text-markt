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
      padding: const EdgeInsets.only(left: 0, right: 7),
      child: TextField(
        readOnly: readOnly,
        keyboardType: inputType,
        obscureText: obscureText,
        cursorColor: Colors.grey.shade600,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        controller: controller,
        decoration: InputDecoration(
          errorText: errorText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
          ),
          border: const UnderlineInputBorder(),
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        ),
      ),
    );
  }
}
