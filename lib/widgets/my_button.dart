import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.icon,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    final fontSize = isTablet ? 50.0 : 14.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 75 / 1000),
      child: SizedBox(
        height: screenHeight * 7 / 100,
        width: 70,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: Theme.of(
              context,
            ).elevatedButtonTheme.style!.backgroundColor,
          ),
          onPressed: onPressed,
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: isTablet ? 30 : 20),
                    const SizedBox(width: 8),
                    Text(
                      buttonText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
        ),
      ),
    );
  }
}
