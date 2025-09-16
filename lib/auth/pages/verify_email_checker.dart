import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/widgets/app_controller.dart';

class VerifyEmailChecker extends StatefulWidget {
  const VerifyEmailChecker({super.key});

  @override
  State<VerifyEmailChecker> createState() => _VerifyEmailCheckerState();
}

class _VerifyEmailCheckerState extends State<VerifyEmailChecker> {
  bool isVerifyedEmail = false;
  bool canResendEmail = false;
  Timer? timer;
  int remainingTime = 59;

  @override
  void initState() {
    super.initState();

    isVerifyedEmail = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerifyedEmail) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerifyedEmail = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerifyedEmail) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
        remainingTime = 59;
      });
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            canResendEmail = true;
            t.cancel();
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      message(
        context,
        title: 'error',
        content: e.message.toString(),
        buttonText: 'try again later',
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isVerifyedEmail
        ? const AppController()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: const Text('Verify Email'),
              backgroundColor: const Color.fromARGB(255, 2, 133, 120),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/auth/verify-email.png'),
                  const Text(
                    'Check your email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  const Text(
                    'We sent a verification link to verify your account.',
                    style: TextStyle(fontFamily: 'Ubuntu'),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff7271fd),
                      ),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.email_rounded),
                          const SizedBox(width: 8),
                          canResendEmail
                              ? const Text(
                                  'Re-send Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                )
                              : Text(
                                  'Re-send in $remainingTime seconds',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          253,
                          113,
                          113,
                        ),
                      ),
                      onPressed: () {
                        AuthService().signOut();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
