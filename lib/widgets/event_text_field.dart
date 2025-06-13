import 'package:flutter/material.dart';

class EventTextField extends StatelessWidget {
  const EventTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fieldTitle,
    this.suffixIcon,
    required this.readOnly,
    this.maxLines,
  });

  final TextEditingController controller;
  final String hintText;
  final String fieldTitle;
  final Widget? suffixIcon;
  final bool readOnly;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                fieldTitle,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          TextField(
            maxLines: maxLines,
            controller: controller,
            readOnly: readOnly,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
