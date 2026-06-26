import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();

  User? getCurrentUser();

  Future<void> signIn(String email, String password);

  Future<void> signUp(String email, String password, String fullName);

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<void> sendEmailVerification();

  Future<bool> checkEmailVerified();
}
