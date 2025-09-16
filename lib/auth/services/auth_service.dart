import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        return loc.thisFieldIsRequired;
      } else if (!isValidEmail(emailController.text) &&
          emailController.text.isNotEmpty) {
        return loc.invalidEmailAddress;
      } else {
        return null;
      }
    } else if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return loc.thisFieldIsRequired;
      } else if ((passwordController.text.length < 7 &&
              passwordController.text.isNotEmpty) &&
          emailController.text.isNotEmpty) {
        return loc.passwordMinChars;
      } else {
        return null;
      }
    } else {
      if (isValidEmail(emailController.text) &&
          passwordController.text.length >= 7 &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        return loc.validSignin;
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
        return S().thisFieldIsRequired;
      } else if (!isValidEmail(emailController.text) &&
          emailController.text.isNotEmpty) {
        return S().invalidEmailAddress;
      } else {
        return null;
      }
    } else if (credential == 'fullname') {
      if (fullNameController.text.isEmpty) {
        return S().thisFieldIsRequired;
      } else if (fullNameController.text.length < 4 &&
          fullNameController.text.isNotEmpty) {
        return S().usernameMinChars;
      } else {
        return null;
      }
    } else if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return S().thisFieldIsRequired;
      } else if ((passwordController.text.length < 7 &&
              passwordController.text.isNotEmpty) &&
          emailController.text.isNotEmpty) {
        return S().passwordMinChars;
      } else {
        return null;
      }
    } else if (credential == 'confirmPassword') {
      if (confirmPasswordController.text.isEmpty) {
        return S().thisFieldIsRequired;
      }
      if (passwordController.text != confirmPasswordController.text &&
          passwordController.text.length >= 7 &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        return S().passwordsDontMatch;
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

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUp(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      FirebaseFirestore.instance.collection('users');

      firestore.collection("users").doc(userCredential.user!.email).set({
        'email': email.trim(),
        'FullName': fullName.trim(),
        'uid': userCredential.user!.uid,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
