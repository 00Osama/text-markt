import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: 50,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                Theme.of(context).elevatedButtonTheme.style!.backgroundColor,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
