import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.operation,
    this.icon,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final String? operation;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    final fontSize = isTablet ? 50.0 : 14.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 75 / 1000),
      child: SizedBox(
        height: screenHeight * 7 / 100,
        width: 70,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              operation == 'out'
                  ? (isDark
                        ? const Color(0xFF8B3A3A)
                        : const Color.fromARGB(255, 186, 103, 103))
                  : null,
            ),
          ),
          onPressed: onPressed,
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: isTablet ? 30 : 20,
                      color: operation == 'out' ? Colors.white : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      buttonText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                        color: operation == 'out' ? Colors.white : null,
                      ),
                    ),
                  ],
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    color: operation == 'out' ? Colors.white : null,
                  ),
                ),
        ),
      ),
    );
  }
}
