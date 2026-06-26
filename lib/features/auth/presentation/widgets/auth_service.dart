import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class AuthService {
  bool isValidEmail(String email) {
    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    if (regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  String? checkSigninCredential({
    required BuildContext context,
    required String credential,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    final loc = S();

    if (credential == 'email') {
      if (emailController.text.isEmpty) {
        return loc.fieldRequired;
      } else if (!isValidEmail(emailController.text) &&
          emailController.text.isNotEmpty) {
        return loc.invalidEmail;
      } else {
        return null;
      }
    } else if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return loc.fieldRequired;
      } else if ((passwordController.text.length < 7 &&
              passwordController.text.isNotEmpty) &&
          emailController.text.isNotEmpty) {
        return loc.passwordMinLength;
      } else {
        return null;
      }
    } else {
      if (isValidEmail(emailController.text) &&
          passwordController.text.length >= 7 &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        return "valid signin";
      } else {
        return loc.invalidSignin;
      }
    }
  }

  Future<String?> checkSignUpCredential({
    required String credential,
    required TextEditingController fullNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
  }) async {
    if (credential == 'email') {
      if (emailController.text.isEmpty) {
        return S().fieldRequired;
      } else if (!isValidEmail(emailController.text) &&
          emailController.text.isNotEmpty) {
        return S().invalidEmail;
      } else {
        return null;
      }
    } else if (credential == 'fullname') {
      if (fullNameController.text.isEmpty) {
        return S().fieldRequired;
      } else if (fullNameController.text.length < 4 &&
          fullNameController.text.isNotEmpty) {
        return S().usernameMinLength;
      } else {
        return null;
      }
    } else if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return S().fieldRequired;
      } else if ((passwordController.text.length < 7 &&
              passwordController.text.isNotEmpty) &&
          emailController.text.isNotEmpty) {
        return S().passwordMinLength;
      } else {
        return null;
      }
    } else if (credential == 'confirmPassword') {
      if (confirmPasswordController.text.isEmpty) {
        return S().fieldRequired;
      }
      if (passwordController.text != confirmPasswordController.text &&
          passwordController.text.length >= 7 &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        return S().passwordsNotMatch;
      } else {
        return null;
      }
    } else {
      if (fullNameController.text.length >= 4 &&
          passwordController.text == confirmPasswordController.text &&
          passwordController.text.length >= 7 &&
          isValidEmail(emailController.text) &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          fullNameController.text.length >= 4) {
        return 'valid signup';
      } else {
        return 'invalid signup';
      }
    }
  }

}
