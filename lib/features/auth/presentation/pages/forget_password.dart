import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/core/helpers/success_snackbar_helper.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/core/widgets/my_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  String? emailErrorText;

  bool isValidEmail(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    if (regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = Responsive.isTablet(context);
    final contentWidth = isTablet
        ? Responsive.tabletContentWidth
        : double.infinity;
    final buttonFontSize = isTablet ? 22.0 : 18.0;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => LoadingAnimationWidget.threeRotatingDots(
              color: const Color.fromARGB(255, 67, 143, 224),
              size: 90,
            ),
          );
        } else if (state is AuthResetPasswordSuccess) {
          context.pop();
          context.pop();
          successSnackBar(
            context: context,
            title: S().resetEmailSentSuccessfully,
          );
        } else if (state is AuthResetPasswordUserNotFound) {
          context.pop();
          context.pop();
          setState(() {
            emailErrorText = S().userNotFound;
          });
        } else if (state is AuthFail) {
          context.pop();
          errorSnackBar(context: context, title: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isTablet ? 80 : 40),
          child: AppBar(
            title: Text(
              S().resetPasswordTitle,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: isTablet ? 24 : 18,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),

        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S().typeYourEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      S().resetPasswordHint,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 0.0 : 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: isTablet ? 60 : 40,
                            height: isTablet ? 60 : 40,
                            padding: EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/images/email.png',
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: isTablet ? 20.0 : 0),
                          Expanded(
                            child: MyTextField(
                              readOnly: false,
                              controller: emailController,
                              hintText: S().emailAddress,
                              obscureText: false,
                              errorText: emailErrorText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 45),
                    SizedBox(
                      height: screenHeight * 7 / 100,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (!isValidEmail(emailController.text) &&
                              emailController.text.isNotEmpty) {
                            emailErrorText = S().invalidEmail;
                            setState(() {});
                          } else if (emailController.text.isEmpty) {
                            emailErrorText = S().fieldRequired;
                            setState(() {});
                          } else {
                            emailErrorText = null;
                            setState(() {});
                            context.read<AuthCubit>().resetPassword(
                              emailController.text,
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_rounded),
                            Text(
                              ' ${S().sendLink}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: buttonFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: screenHeight * 7 / 100,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.error,
                          ),
                        ),
                        onPressed: () {
                          context.pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S().cancel,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: buttonFontSize,
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
        ),
      ),
    );
  }
}
