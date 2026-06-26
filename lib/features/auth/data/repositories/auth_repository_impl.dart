import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<User?> authStateChanges() {
    return remoteDataSource.authStateChanges();
  }

  @override
  User? getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> signIn(String email, String password) {
    return remoteDataSource.signIn(email, password);
  }

  @override
  Future<void> signUp(String email, String password, String fullName) {
    return remoteDataSource.signUp(email, password, fullName);
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) {
    return remoteDataSource.resetPassword(email);
  }

  @override
  Future<void> sendEmailVerification() {
    return remoteDataSource.sendEmailVerification();
  }

  @override
  Future<bool> checkEmailVerified() {
    return remoteDataSource.checkEmailVerified();
  }
}
