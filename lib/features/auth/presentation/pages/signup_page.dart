import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/features/auth/presentation/pages/signin_page.dart';
import 'package:text_markt/features/auth/presentation/widgets/auth_gate.dart';
import 'package:text_markt/features/auth/presentation/widgets/auth_service.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/core/widgets/my_button.dart';
import 'package:text_markt/core/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? fullNameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isTablet = screenWidth > 600;
    return BlocListener<AuthCubit, AuthState>(
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
        } else if (state is AuthSignUpSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthGate()),
          );
        } else if (state is AuthFail) {
          Navigator.pop(context);
          if (state.error.contains('email-already-in-use')) {
            errorSnackBar(
              context: context,
              title: S.of(context).emailAlreadyInUse,
            );
            setState(() {
              emailErrorText = S.of(context).emailAlreadyInUse;
            });
          } else {
            errorSnackBar(context: context, title: state.error);
          }
        }
      },
      child: Scaffold(
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
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge?.copyWith(),
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
                    context.read<AuthCubit>().signUp(
                      emailController.text,
                      passwordController.text,
                      fullNameController.text,
                    );
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
                          builder: (context) => const SignInPage(),
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
      ),
    );
  }
}
