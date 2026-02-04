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
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    final fontSize = isTablet ? 50.0 : 14.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 75 / 1000),
      child: SizedBox(
        height: screenHeight * 0.06,
        width: 70,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: Theme.of(
              context,
            ).elevatedButtonTheme.style!.backgroundColor,
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
