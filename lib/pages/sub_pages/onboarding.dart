import 'package:flutter/material.dart';
import 'package:textmarkt/auth/pages/signin_screen.dart';
import 'package:textmarkt/widgets/onboarding_button.dart';
import 'package:textmarkt/widgets/onboarding_indicator.dart';

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
      MaterialPageRoute(
        builder: (context) => const SigninScreen(),
      ),
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
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xff007AFF),
                  ),
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
            'Manage your',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          Text(
            'notes easily',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              'A completely easy way to manage and customize your notes.',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
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
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xff007AFF),
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xff007AFF),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: goToAuth,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Color(0xff007AFF),
                  ),
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
            'Organize your',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          Text(
            'thoughts',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              'Most beautiful note-taking application.',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
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
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xff007AFF),
                    ),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xff007AFF),
                      ),
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
            'Create cards and',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          Text(
            'easy styling',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.08,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              'Making your content legible has never been easier.',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
          const SizedBox(height: 35),
          OnboardingButton(
            index: myIndex,
            onPressed: goToAuth,
          ),
        ],
      ),
    ];

    return PageView.builder(
      controller: controller,
      itemCount: screens.length,
      itemBuilder: (context, index) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: screens[index],
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
