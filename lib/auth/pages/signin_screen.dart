import 'package:flutter/material.dart';
import 'package:textmarkt/auth/pages/forget_password.dart';
import 'package:textmarkt/auth/pages/signup_screen.dart';
import 'package:textmarkt/auth/services/auth_gate.dart';
import 'package:textmarkt/auth/services/auth_service.dart';
import 'package:textmarkt/auth/services/error_message.dart';
import 'package:textmarkt/widgets/my_button.dart';
import 'package:textmarkt/widgets/my_text_field.dart';

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
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
    try {
      await auth.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthGate(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (e.toString().contains('user-not-found')) {
        emailErrorText = 'user not found';
        setState(() {});
      } else if (e.toString().contains('wrong-password')) {
        passwordErrorText = 'wrong password';
        setState(() {});
      } else {
        message(
          context,
          title: 'error',
          content: e.toString(),
          buttonText: 'Ok',
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
              const Row(
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Log IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Spacer(flex: 20),
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
                      hintText: 'Email Address',
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
                      hintText: 'Password',
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Forget Password ?!',
                        style: TextStyle(
                          color: Color(0xff007AFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ForgetPasswordScreen();
                        },
                      ));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenWidth * 0.97,
                child: MyButton(
                  buttonText: 'Sign in',
                  onPressed: () {
                    setState(() {
                      emailErrorText = auth.checkSigninCredential(
                        credential: 'email',
                        emailController: emailController,
                        passwordController: passwordController,
                      );
                      passwordErrorText = auth.checkSigninCredential(
                        credential: 'password',
                        emailController: emailController,
                        passwordController: passwordController,
                      );
                    });
                    if (auth.checkSigninCredential(
                          credential: 'signin',
                          emailController: emailController,
                          passwordController: passwordController,
                        ) ==
                        'valid signin') {
                      SignIn();
                    }
                  },
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('don\'t have an account? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'sign up',
                      style: TextStyle(
                        color: Color(0xff007AFF),
                      ),
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
