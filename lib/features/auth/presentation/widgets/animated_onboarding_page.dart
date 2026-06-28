import 'package:flutter/material.dart';
import 'package:text_markt/features/auth/presentation/widgets/onboarding_button.dart';
import 'package:text_markt/features/auth/presentation/widgets/onboarding_indicator.dart';
import 'package:text_markt/generated/l10n.dart';

class AnimatedOnboardingPage extends StatelessWidget {
  const AnimatedOnboardingPage({
    super.key,
    required this.pageIndex,
    required this.currentIndex,
    required this.imagePath,
    required this.titleLine1,
    required this.titleLine2,
    required this.description,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onBackPressed,
  });

  final int pageIndex;
  final int currentIndex;
  final String imagePath;
  final String titleLine1;
  final String titleLine2;
  final String description;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final VoidCallback onBackPressed;

  double animationValue(double value, double start, double end, Curve curve) {
    final progress = ((value - start) / (end - start)).clamp(0.0, 1.0);
    return curve.transform(progress);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return TweenAnimationBuilder<double>(
      key: ValueKey(pageIndex),
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        final topButtonsValue = animationValue(
          value,
          0.00,
          0.35,
          Curves.easeOutCubic,
        );
        final imageValue = animationValue(
          value,
          0.08,
          0.63,
          Curves.easeOutBack,
        );
        final indicatorValue = animationValue(
          value,
          0.30,
          0.70,
          Curves.easeOutCubic,
        );
        final titleValue = animationValue(
          value,
          0.38,
          0.83,
          Curves.easeOutCubic,
        );
        final descriptionValue = animationValue(
          value,
          0.48,
          0.93,
          Curves.easeOutCubic,
        );
        final buttonValue = animationValue(
          value,
          0.62,
          1.00,
          Curves.elasticOut,
        );

        return Opacity(
          opacity: value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, -18 * (1 - topButtonsValue)),
                child: Opacity(
                  opacity: topButtonsValue,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: onSkipPressed,
                        child: Text(
                          S().skip,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      const Spacer(),
                      if (pageIndex > 0)
                        TextButton(
                          onPressed: onBackPressed,
                          child: Text(
                            S().back,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, 65 * (1 - imageValue)),
                child: Transform.rotate(
                  angle: -0.08 * (1 - imageValue),
                  child: Transform.scale(
                    scale: 0.78 + (0.22 * imageValue),
                    child: Image.asset(
                      imagePath,
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.80 + (0.20 * indicatorValue),
                child: Opacity(
                  opacity: indicatorValue,
                  child: OnboardingIndicator(index: pageIndex),
                ),
              ),
              const SizedBox(height: 30),
              Transform.translate(
                offset: Offset(0, 30 * (1 - titleValue)),
                child: Opacity(
                  opacity: titleValue,
                  child: Column(
                    children: [
                      Text(
                        titleLine1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                      Text(
                        titleLine2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Transform.translate(
                offset: Offset(0, 22 * (1 - descriptionValue)),
                child: Opacity(
                  opacity: descriptionValue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Transform.scale(
                scale: 0.70 + (0.30 * buttonValue),
                child: Opacity(
                  opacity: value > 0.62 ? 1 : 0,
                  child: OnboardingButton(
                    index: currentIndex,
                    onPressed: onNextPressed,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
