import 'package:flutter/material.dart';

void message(
  BuildContext context, {
  required String title,
  required String content,
  required String buttonText,
  required void Function()? onPressed,
}) {
  Navigator.push(
    context,
    DialogRoute(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    ),
  );
}
