import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/widgets/my_text_field.dart';

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
    return regExp.hasMatch(email);
  }

  Future sendPasswordReset(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      message(
        context,
        title: S().success,
        content: S().PasswordResetLinkSent,
        buttonText: S().ok,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } on FirebaseAuthException catch (e) {
      message(
        context,
        title: S().error,
        content: e.message.toString(),
        buttonText: S().tryAgain,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : Colors.grey[300],
      appBar: AppBar(
        title: Text(
          S.of(context).resetPassword,
          style: TextStyle(fontFamily: 'Ubuntu'),
        ),
        backgroundColor: isDark
            ? const Color(0xFF1E1E1E) // Dark mode appbar
            : const Color.fromARGB(255, 2, 133, 120), // Light mode appbar
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).TypeYourEmailAddress,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    S.of(context).weWillSendApasswordResetLinkForYou,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: isDark ? Colors.grey[300] : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset('assets/images/email.png'),
                      ),
                      Expanded(
                        flex: 8,
                        child: MyTextField(
                          readOnly: false,
                          controller: emailController,
                          hintText: S.of(context).emailAdress,
                          obscureText: false,
                          errorText: emailErrorText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isDark
                            ? const Color(0xFF3D3B91) // Dark mode button
                            : const Color(0xff7271fd), // Light mode button
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (!isValidEmail(emailController.text) &&
                          emailController.text.isNotEmpty) {
                        emailErrorText = S().invalidEmail;
                        setState(() {});
                      } else if (emailController.text.isEmpty) {
                        emailErrorText = S().ThisFieldIsRequired;
                        setState(() {});
                      } else {
                        sendPasswordReset(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_rounded, color: Colors.white),
                        Text(
                          S.of(context).sendEmail,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        isDark
                            ? const Color(0xFF8B1E1E) // Dark mode cancel
                            : const Color.fromARGB(255, 253, 113, 113), // Light
                      ),
                      foregroundColor: const WidgetStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).cancel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
