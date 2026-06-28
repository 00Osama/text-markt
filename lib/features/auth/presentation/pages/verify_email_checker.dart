import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/core/dependency_injection/service_locator.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/responsive.dart';
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
    final isTablet = Responsive.isTablet(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final fontSize = isTablet ? 22.0 : 14.0;
    final imageSize = isTablet ? 360.0 : 280.0;
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
                    style: TextStyle(fontSize: isTablet ? 24 : 18),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 60 : 20,
                    ),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/verifyEmail.png',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
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
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                        height: screenHeight * 0.07,
                        width: double.infinity,
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
                    const SizedBox(height: 10),
                    SizedBox(
                        height: screenHeight * 0.07,
                        width: double.infinity,
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
                  ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
