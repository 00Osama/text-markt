import 'package:flutter/material.dart';
import 'package:text_markt/auth/pages/signin_screen.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/widgets/onboarding_button.dart';
import 'package:text_markt/widgets/onboarding_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late int myIndex = 0;
  final controller = PageController();

  void goToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    List<Widget> screens = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: goToAuth,
                child: Text(
                  S().skip,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/onborading/1.png',
            width: screenWidth * 0.8,
            height: screenHeight * 0.3,
          ),
          const OnboardingIndicator(index: 0),
          const SizedBox(height: 30),
          Text(
            S.of(context).onboarding1TitleLine1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          Text(
            S.of(context).onboarding1TitleLine2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              S.of(context).onboarding1Description,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
          ),
          const SizedBox(height: 35),
          OnboardingButton(
            index: myIndex,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    Text(
                      S().back,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: goToAuth,
                child: Text(
                  S().skip,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/onborading/2.png',
            width: screenWidth * 0.8,
            height: screenHeight * 0.3,
          ),
          const OnboardingIndicator(index: 1),
          const SizedBox(height: 30),
          Text(
            S.of(context).onboarding2TitleLine1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          Text(
            S.of(context).onboarding2TitleLine2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              S.of(context).onboarding2Description,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
          ),
          const SizedBox(height: 35),
          OnboardingButton(
            index: myIndex,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    Text(
                      S().back,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/onborading/3.png',
            width: screenWidth * 0.8,
            height: screenHeight * 0.3,
          ),
          const OnboardingIndicator(index: 2),
          const SizedBox(height: 30),
          Text(
            S.of(context).onboarding3TitleLine1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          Text(
            S.of(context).onboarding3TitleLine2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              S.of(context).onboarding3Description,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(),
            ),
          ),
          const SizedBox(height: 35),
          OnboardingButton(index: myIndex, onPressed: goToAuth),
        ],
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
