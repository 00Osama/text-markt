import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color activeColor =
        isDark ? const Color(0xFF5695FF) : const Color(0xff3A85F7);
    final Color inactiveColor =
        isDark ? const Color(0xFF44444A) : const Color(0xffCECBD3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: screenWidth * 0.07),
        for (int i = 0; i < 3; i++) ...[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Divider(
                height: 6,
                thickness: 6,
                color: index == i ? activeColor : inactiveColor,
              ),
            ),
          ),
          if (i < 2) SizedBox(width: screenWidth * 0.02),
        ],
        SizedBox(width: screenWidth * 0.07),
      ],
    );
  }
}
