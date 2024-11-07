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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: screenWidth * 0.07),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Divider(
              height: 6,
              thickness: 6,
              color: index == 0
                  ? const Color(0xff3A85F7)
                  : const Color(0xffCECBD3),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Divider(
              height: 6,
              thickness: 6,
              color: index == 1
                  ? const Color(0xff3A85F7)
                  : const Color(0xffCECBD3),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Divider(
              height: 6,
              thickness: 6,
              color: index == 2
                  ? const Color(0xff3A85F7)
                  : const Color(0xffCECBD3),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.07),
      ],
    );
  }
}
