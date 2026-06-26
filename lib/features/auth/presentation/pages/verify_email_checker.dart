import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/core/dependency_injection/service_locator.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/core/widgets/bottom_nav_bar.dart';

class VerifyEmailChecker extends StatefulWidget {
  const VerifyEmailChecker({super.key});

  @override
  State<VerifyEmailChecker> createState() => _VerifyEmailCheckerState();
}

class _VerifyEmailCheckerState extends State<VerifyEmailChecker> {
  bool isVerifyedEmail = false;
  bool canResendEmail = false;
  Timer? timer;
  Timer? resendTimer;
  int remainingTime = 59;

  @override
  void initState() {
    super.initState();

    isVerifyedEmail =
        ServiceLocator.authRepository.getCurrentUser()?.emailVerified ?? false;

    if (!isVerifyedEmail) {
      checkEmailVerified();
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    resendTimer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await context.read<AuthCubit>().checkEmailVerified();
  }

  Future sendVerificationEmail() async {
    await context.read<AuthCubit>().sendEmailVerification();
    if (!mounted) return;

    resendTimer?.cancel();
    setState(() {
      canResendEmail = false;
      remainingTime = 59;
    });

    resendTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!mounted) {
        t.cancel();
        return;
      }

      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          canResendEmail = true;
          t.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width > 600;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final fontSize = isTablet ? 50.0 : 14.0;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthEmailVerified) {
          setState(() {
            isVerifyedEmail = state.isVerified;
          });
          if (state.isVerified) {
            timer?.cancel();
            resendTimer?.cancel();
          }
        } else if (state is AuthFail) {
          errorSnackBar(context: context, title: state.error);
        }
      },
      child: isVerifyedEmail
          ? const BottomNavBar()
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
                      'assets/images/verifyEmail.png',
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
                    Center(
                      child: Text(
                        S().verificationHint,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
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
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.error,
                          ),
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
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
            ),
    );
  }
}
