import 'package:flutter/material.dart';

void message(
  BuildContext context, {
  required String title,
  required String content,
  required String buttonText,
  required void Function()? onPressed,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  Navigator.push(
    context,
    DialogRoute(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark
              ? const Color(0xFF1E2A28) // Dark mode background
              : const Color(0xFFB2DFDB), // Light mode background
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: isDark ? Colors.tealAccent : Colors.teal[900],
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
