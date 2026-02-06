import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/pages/signin_screen.dart';
import 'package:text_markt/auth/services/auth_gate.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/auth/services/error_message.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/widgets/my_button.dart';
import 'package:text_markt/widgets/my_text_field.dart';

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
      await auth.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
        fullNameController.text.trim(),
      );
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthGate()),
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
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Image.asset(
              'assets/images/signup_ill.png',

              width: double.infinity,
              height: isTablet ? screenHeight * 0.35 : screenHeight * 0.25,
              fit: BoxFit.contain,
            ),
            Row(
              children: [
                const Spacer(flex: 1),
                Text(
                  S().signUp,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(),
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
                      'assets/images/name.png',
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: isTablet ? 20.0 : 0),
                  Expanded(
                    child: MyTextField(
                      readOnly: false,
                      controller: fullNameController,
                      hintText: S().fullName,
                      obscureText: false,
                      errorText: fullNameErrorText,
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
                      controller: confirmPasswordController,
                      hintText: S().confirmPassword,
                      obscureText: true,
                      errorText: confirmPasswordErrorText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            MyButton(
              buttonText: S().signUp,
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S().alreadyHaveAnAccount),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninScreen(),
                      ),
                    );
                  },
                  child: Text(
                    S().signIn,
                    style: TextStyle(color: Color(0xff007AFF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
