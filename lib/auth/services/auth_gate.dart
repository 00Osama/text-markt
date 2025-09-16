import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/pages/verify_email_checker.dart';
import 'package:text_markt/pages/sub_pages/onboarding.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: const Color.fromARGB(255, 67, 143, 224),
              size: 90,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong.'));
        } else if (snapshot.hasData) {
          return const VerifyEmailChecker();
        } else {
          return const Onboarding();
        }
      },
    );
  }
}
