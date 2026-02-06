import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    if (regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  Future sendPasswordReset(context) async {
    showDialog(
      context: context,
      builder: (context) => LoadingAnimationWidget.threeRotatingDots(
        color: const Color.fromARGB(255, 67, 143, 224),
        size: 90,
      ),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      message(
        context,
        title: S().successTitle,
        content: S().resetLinkSent,
        buttonText: S().ok,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      message(
        context,
        title: S().errorTitle,
        content: e.message.toString(),
        buttonText: S().tryAgain,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isTablet ? 80 : 40),
        child: AppBar(
          title: Text(
            S().resetPasswordTitle,
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: isTablet ? 55 : 18,
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
                      horizontal: isTablet ? 40.0 : 10,
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
                          sendPasswordReset(context);
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
                              fontSize: MediaQuery.sizeOf(context).width < 600
                                  ? 18
                                  : 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: screenHeight * 7 / 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.error,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S().cancel,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: MediaQuery.sizeOf(context).width < 600
                                  ? 18
                                  : 40,
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
