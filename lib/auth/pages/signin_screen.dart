import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/pages/forget_password.dart';
import 'package:text_markt/auth/pages/signup_screen.dart';
import 'package:text_markt/auth/services/auth_gate.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/widgets/my_button.dart';
import 'package:text_markt/widgets/my_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;
  final auth = AuthService();

  void SignIn() async {
    showDialog(
      context: context,
      builder: (context) => LoadingAnimationWidget.threeRotatingDots(
        color: const Color.fromARGB(255, 67, 143, 224),
        size: 90,
      ),
    );
    try {
      allNotes = [];
      favourites = [];
      hidden = [];
      trash = [];
      events = [];
      user = null;
      hiddenNotesPin = null;
      await auth.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
        (route) => false,
      );
    } catch (e) {
      if (e.toString().contains('user-not-found')) {
        emailErrorText = S().userNotFound;
        setState(() {});
      } else if (e.toString().contains('wrong-password')) {
        passwordErrorText = S().wrongPassword;
        setState(() {});
      } else {
        message(
          context,
          title: S().error,
          content: e.toString(),
          buttonText: S().ok,
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    final isLandscape = screenWidth > screenHeight;

    final forgetPasswordFontSize = isTablet ? 50.0 : 19.0;
    final signUpTextFontSize = isTablet ? 50.0 : 19.0;
    final topPadding = isLandscape ? 10.0 : 30.0;
    final spaceBetweenElements = isLandscape ? 15.0 : 25.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: topPadding),
            Image.asset(
              'assets/images/login_ill.png',
              width: double.infinity,
              height: isTablet ? screenHeight * 0.35 : screenHeight * 0.25,
              fit: BoxFit.contain,
            ),
            SizedBox(height: spaceBetweenElements),
            Row(
              children: [
                const Spacer(flex: 1),
                Text(
                  S.of(context).signIn,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 20),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40.0 : 10),
              child: Row(
                children: [
                  Container(
                    width: isTablet ? 60 : 40,
                    height: isTablet ? 60 : 40,
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/email.png',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40.0 : 10),
              child: Row(
                children: [
                  Container(
                    width: isTablet ? 60 : 40,
                    height: isTablet ? 60 : 40,
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/password.png',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: isTablet ? 20.0 : 0),
                  Expanded(
                    child: MyTextField(
                      readOnly: false,
                      controller: passwordController,
                      hintText: S().password,
                      obscureText: true,
                      errorText: passwordErrorText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isLandscape ? 20.0 : 40.0),
            Row(
              children: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 50.0 : 15.0,
                    ),
                    child: Text(
                      S().forgotPassword,
                      style: TextStyle(
                        color: const Color(0xff007AFF),
                        fontWeight: FontWeight.bold,
                        fontSize: forgetPasswordFontSize,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgetPasswordScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            MyButton(
              buttonText: S.of(context).signIn,
              onPressed: () {
                setState(() {
                  emailErrorText = auth.checkSigninCredential(
                    context: context,
                    credential: 'email',
                    emailController: emailController,
                    passwordController: passwordController,
                  );
                  passwordErrorText = auth.checkSigninCredential(
                    context: context,
                    credential: 'password',
                    emailController: emailController,
                    passwordController: passwordController,
                  );
                });
                if (auth.checkSigninCredential(
                      context: context,
                      credential: 'signin',
                      emailController: emailController,
                      passwordController: passwordController,
                    ) ==
                    'valid signin') {
                  SignIn();
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).dontHaveAnAccount,
                  style: TextStyle(fontSize: signUpTextFontSize),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    S.of(context).signUp,
                    style: TextStyle(
                      color: const Color(0xff007AFF),
                      fontSize: signUpTextFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
