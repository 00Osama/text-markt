import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:textmarkt/auth/services/auth_gate.dart';
import 'package:textmarkt/auth/services/auth_service.dart';
import 'package:textmarkt/auth/services/error_message.dart';
import 'package:textmarkt/widgets/my_button.dart';
import 'package:textmarkt/widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? fullNameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final auth = AuthService();
  Future<bool> userExists(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  void userSignUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );

    try {
      await auth.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        fullNameController.text.trim(),
      );
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthGate(),
        ),
      );
    } catch (e) {
      print('-----------------------------------------');
      print(e);
      print('-----------------------------------------');

      Navigator.pop(context);
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Image.asset(
            'assets/app/launcherIcon.png',
            width: screenWidth * 0.70,
            height: screenWidth * 0.70,
          ),
          const Text(
            'you can create new account now!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          MyTextField(
            readOnly: false,
            controller: fullNameController,
            hintText: 'Full Name',
            obscureText: false,
            errorText: fullNameErrorText,
          ),
          const SizedBox(height: 20),
          MyTextField(
            readOnly: false,
            controller: emailController,
            hintText: 'Email Address',
            obscureText: false,
            errorText: emailErrorText,
          ),
          const SizedBox(height: 20),
          MyTextField(
            readOnly: false,
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            errorText: passwordErrorText,
          ),
          const SizedBox(height: 20),
          MyTextField(
            readOnly: false,
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            obscureText: true,
            errorText: confirmPasswordErrorText,
          ),
          const SizedBox(height: 60),
          MyButton(
            buttonText: 'Sign up',
            onPressed: () async {
              if (await auth.checkSignUpCredential(
                    credential: 'signup',
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ) ==
                  'invalid signup') {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                );
              }
              fullNameErrorText = await auth.checkSignUpCredential(
                credential: 'fullname',
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              );

              emailErrorText = await auth.checkSignUpCredential(
                credential: 'email',
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              );
              passwordErrorText = await auth.checkSignUpCredential(
                credential: 'password',
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              );

              confirmPasswordErrorText = await auth.checkSignUpCredential(
                credential: 'confirmPassword',
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              );
              setState(() {});
              if (await auth.checkSignUpCredential(
                    credential: 'signup',
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ) ==
                  'invalid signup') {
                Navigator.pop(context);
              }

              if (await auth.checkSignUpCredential(
                    credential: 'signup',
                    fullNameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                  ) ==
                  'valid signup') {
                userSignUp();
              }
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
