import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/pages/forget_password.dart';
import 'package:text_markt/auth/pages/signup_screen.dart';
import 'package:text_markt/auth/services/auth_gate.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/generated/l10n.dart';
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
    final loc = S();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: LoadingAnimationWidget.threeRotatingDots(
            color: const Color.fromARGB(255, 67, 143, 224),
            size: 90,
          ),
        );
      },
    );
    try {
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
      Navigator.pop(context);
      if (e.toString().contains('user-not-found')) {
        emailErrorText = loc.userNotFound;
        setState(() {});
      } else if (e.toString().contains('wrong-password')) {
        passwordErrorText = loc.wrongPassword;
        setState(() {});
      } else {
        message(
          context,
          title: loc.error,
          content: e.toString(),
          buttonText: loc.ok,
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final loc = S();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/images/login_ill.png',
                width: screenWidth * 0.70,
                height: screenWidth * 0.70,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Spacer(flex: 1),
                  Text(
                    loc.logIn,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Spacer(flex: 20),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/email.png',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: MyTextField(
                      readOnly: false,
                      controller: emailController,
                      hintText: loc.emailAddress,
                      obscureText: false,
                      errorText: emailErrorText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      'assets/images/password.png',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: MyTextField(
                      readOnly: false,
                      controller: passwordController,
                      hintText: loc.password,
                      obscureText: true,
                      errorText: passwordErrorText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        loc.forgetPassword,
                        style: const TextStyle(
                          color: Color(0xff007AFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
              SizedBox(
                width: screenWidth * 0.97,
                child: MyButton(
                  buttonText: loc.signIn,
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
                        loc.validSignin) {
                      SignIn();
                    }
                  },
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loc.dontHaveAccount),
                  Text(' '),
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
                      loc.signUp,
                      style: const TextStyle(color: Color(0xff007AFF)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
