import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_markt/generated/l10n.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String? checkSigninCredential({
    required String credential,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    if (credential == 'email') {
      if (emailController.text.isEmpty) {
        return S().fieldRequired;
      } else if (!isValidEmail(emailController.text)) {
        return S().invalidEmail;
      }
      return null;
    }

    if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return S().fieldRequired;
      } else if (passwordController.text.length < 7) {
        return S().passwordMinLength;
      }
      return null;
    }

    if (isValidEmail(emailController.text) &&
        passwordController.text.length >= 7) {
      return "valid signin";
    } else {
      return "invalid signin";
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
      } else if (!isValidEmail(emailController.text)) {
        return S().invalidEmail;
      }
      return null;
    }

    if (credential == 'fullname') {
      if (fullNameController.text.isEmpty) {
        return S().fieldRequired;
      } else if (fullNameController.text.length < 4) {
        return S().usernameMinLength;
      }
      return null;
    }

    if (credential == 'password') {
      if (passwordController.text.isEmpty) {
        return S().fieldRequired;
      } else if (passwordController.text.length < 7) {
        return S().passwordMinLength;
      }
      return null;
    }

    if (credential == 'confirmPassword') {
      if (confirmPasswordController.text.isEmpty) {
        return S().fieldRequired;
      } else if (passwordController.text != confirmPasswordController.text) {
        return S().passwordsNotMatch;
      }
      return null;
    }

    if (fullNameController.text.length >= 4 &&
        passwordController.text.length >= 7 &&
        passwordController.text == confirmPasswordController.text &&
        isValidEmail(emailController.text)) {
      return "valid signup";
    } else {
      return "invalid signup";
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        'email': email.trim(),
        'fullName': fullName.trim(),
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
