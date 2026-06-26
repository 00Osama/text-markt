import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({
    required this.auth,
    required this.firestore,
  });

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signUp(String email, String password, String fullName) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await createUserDocument(
      UserModel(
        uid: userCredential.user!.uid,
        email: email.trim(),
        fullName: fullName.trim(),
      ),
    );
  }

  Future<void> createUserDocument(UserModel user) async {
    await firestore.collection('users').doc(user.email).set(user.toJson());
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Future<bool> checkEmailVerified() async {
    await auth.currentUser!.reload();
    return auth.currentUser!.emailVerified;
  }
}
