import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.onPressed,
    required this.index,
  });

  final VoidCallback onPressed;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isMobile = screenWidth < 600;

    // Responsive dimensions
    final buttonWidth = isMobile ? screenWidth * 0.90 : screenWidth * 0.85;
    final buttonHeight = isMobile ? 50.0 : screenHeight * 0.06;
    final buttonPadding = isMobile
        ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
        : EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: 20);
    final textSize = isMobile ? 20.0 : 55.0;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: Theme.of(
            context,
          ).elevatedButtonTheme.style!.backgroundColor,
          padding: WidgetStateProperty.all(buttonPadding),
        ),
        onPressed: onPressed,
        child: Text(
          index == 0 || index == 1 ? S().next : S().getStarted,
          style: TextStyle(fontSize: textSize),
        ),
      ),
    );
  }
}
