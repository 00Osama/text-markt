import 'package:flutter/material.dart';

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
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(0xff007AFF),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          index == 0 || index == 1 ? 'Next' : 'Get Started',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
