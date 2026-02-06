import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/generated/l10n.dart';
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
        title: S().errorTitle,
        content: e.message.toString(),
        buttonText: S().tryAgainLater,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final fontSize = isTablet ? 50.0 : 14.0;
    return isVerifyedEmail
        ? const AppController()
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(isTablet ? 80 : 40),
              child: AppBar(
                title: Text(
                  S().verifyEmailTitle,
                  style: TextStyle(fontSize: isTablet ? 55 : 18),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/auth/verify-email.png',
                    width: isTablet ? 700 : 400,
                    height: isTablet ? 700 : 400,
                  ),
                  Text(
                    S().checkYourEmail,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    S().verificationHint,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: canResendEmail
                            ? sendVerificationEmail
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email_rounded),
                            const SizedBox(width: 8),
                            canResendEmail
                                ? Text(
                                    S().resendEmail,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                      fontSize: fontSize,
                                    ),
                                  )
                                : Text(
                                    S().resendInSeconds(remainingTime),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Ubuntu',
                                      fontSize: fontSize,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          AuthService().signOut();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S().cancel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
