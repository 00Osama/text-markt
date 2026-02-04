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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ],
          ),
          const SizedBox(height: 3),
          TextField(
            maxLines: maxLines,
            controller: controller,
            readOnly: readOnly,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(),
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
