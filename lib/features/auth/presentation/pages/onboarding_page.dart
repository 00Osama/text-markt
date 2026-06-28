import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:text_markt/core/routing/app_router.dart';
import 'package:text_markt/features/auth/presentation/widgets/animated_onboarding_page.dart';
import 'package:text_markt/generated/l10n.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late int myIndex = 0;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void goToAuth() {
    context.go(AppRoutes.signIn);
  }

  void goToPreviousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      AnimatedOnboardingPage(
        pageIndex: 0,
        currentIndex: myIndex,
        imagePath: 'assets/images/onborading1.png',
        titleLine1: S.of(context).onboarding1TitleLine1,
        titleLine2: S.of(context).onboarding1TitleLine2,
        description: S.of(context).onboarding1Description,
        onNextPressed: () {
          controller.nextPage(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
          );
        },
        onSkipPressed: goToAuth,
        onBackPressed: goToPreviousPage,
      ),
      AnimatedOnboardingPage(
        pageIndex: 1,
        currentIndex: myIndex,
        imagePath: 'assets/images/onborading2.png',
        titleLine1: S.of(context).onboarding2TitleLine1,
        titleLine2: S.of(context).onboarding2TitleLine2,
        description: S.of(context).onboarding2Description,
        onNextPressed: () {
          controller.nextPage(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
          );
        },
        onSkipPressed: goToAuth,
        onBackPressed: goToPreviousPage,
      ),
      AnimatedOnboardingPage(
        pageIndex: 2,
        currentIndex: myIndex,
        imagePath: 'assets/images/onborading3.png',
        titleLine1: S.of(context).onboarding3TitleLine1,
        titleLine2: S.of(context).onboarding3TitleLine2,
        description: S.of(context).onboarding3Description,
        onNextPressed: goToAuth,
        onSkipPressed: goToAuth,
        onBackPressed: goToPreviousPage,
      ),
    ];

    return PageView.builder(
      controller: controller,
      itemCount: screens.length,
      itemBuilder: (context, index) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: screens[index],
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
          ),
        );
      },
      onPageChanged: (int index) {
        setState(() {
          myIndex = index;
        });
      },
    );
  }
}
