import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textmarkt/auth/pages/verify_email_checker.dart';
import 'package:textmarkt/pages/sub_pages/onboarding.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong.'),
          );
        } else if (snapshot.hasData) {
          return const VerifyEmailChecker();
        } else {
          return const Onboarding();
        }
      },
    );
  }
}
