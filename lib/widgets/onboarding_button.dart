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

    return SizedBox(
      width: screenWidth * 0.90,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: Theme.of(
            context,
          ).elevatedButtonTheme.style!.backgroundColor,
        ),
        onPressed: onPressed,
        child: Text(index == 0 || index == 1 ? S().Next : S().getStarted),
      ),
    );
  }
}
