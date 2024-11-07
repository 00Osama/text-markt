import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textmarkt/auth/services/error_message.dart';
import 'package:textmarkt/widgets/my_text_field.dart';

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

  Future sendPasswordReset(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      message(
        context,
        title: 'Success',
        content: 'password reset link sent!, check your email.',
        buttonText: 'Ok',
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } on FirebaseAuthException catch (e) {
      message(
        context,
        title: 'error',
        content: e.message.toString(),
        buttonText: 'try again',
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(
            fontFamily: 'Ubuntu',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 133, 120),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'type your email address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
            const Text(
              'we will send password reset link for you',
              style: TextStyle(
                fontFamily: 'Ubuntu',
              ),
            ),
            const SizedBox(height: 40),
            MyTextField(
              readOnly: false,
              controller: emailController,
              hintText: 'Email Address',
              obscureText: false,
              errorText: emailErrorText,
            ),
            const SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff7271fd),
                  ),
                ),
                onPressed: () {
                  if (!isValidEmail(emailController.text) &&
                      emailController.text.isNotEmpty) {
                    emailErrorText = 'invalid email address';
                    setState(() {});
                  } else if (emailController.text.isEmpty) {
                    emailErrorText = 'this field is required';
                    setState(() {});
                  } else {
                    sendPasswordReset(context);
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      ' Send Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(255, 253, 113, 113),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Canel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
