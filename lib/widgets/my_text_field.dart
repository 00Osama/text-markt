import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
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
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile ? 0.0 : 16.0;

    return Padding(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding + 7,
      ),
      child: TextField(
        readOnly: widget.readOnly,
        keyboardType: widget.inputType,
        obscureText: _obscureText,
        cursorColor: Colors.grey.shade600,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        controller: widget.controller,
        decoration: InputDecoration(
          errorText: widget.errorText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey.shade600,
                    size: isMobile ? 20 : 50,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 2.0),
          ),
          border: const UnderlineInputBorder(),
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(),
        ),
      ),
    );
  }
}
