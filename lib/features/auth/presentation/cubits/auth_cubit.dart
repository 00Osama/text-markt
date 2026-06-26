import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/features/auth/domain/usecases/check_email_verified_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:text_markt/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:text_markt/globals.dart';

class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignInSuccess extends AuthState {}

class AuthSignUpSuccess extends AuthState {}

class AuthSignOutSuccess extends AuthState {}

class AuthResetPasswordSuccess extends AuthState {}

class AuthResetPasswordUserNotFound extends AuthState {}

class AuthSendVerificationSuccess extends AuthState {}

class AuthEmailVerified extends AuthState {
  final bool isVerified;

  AuthEmailVerified({required this.isVerified});
}

class AuthFail extends AuthState {
  final String error;

  AuthFail({required this.error});
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.resetPasswordUseCase,
    required this.sendEmailVerificationUseCase,
    required this.checkEmailVerifiedUseCase,
  }) : super(AuthInitial());

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  final CheckEmailVerifiedUseCase checkEmailVerifiedUseCase;

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      clearUserData();
      await signInUseCase(email, password);
      emit(AuthSignInSuccess());
    } catch (e) {
      emit(AuthFail(error: e.toString()));
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    try {
      emit(AuthLoading());
      clearUserData();
      await signUpUseCase(email, password, fullName);
      emit(AuthSignUpSuccess());
    } catch (e) {
      emit(AuthFail(error: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      clearUserData();
      await signOutUseCase();
      emit(AuthSignOutSuccess());
    } catch (e) {
      emit(AuthFail(error: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await resetPasswordUseCase(email);
      emit(AuthResetPasswordSuccess());
    } catch (e) {
      if (e.toString().contains('user-not-found')) {
        emit(AuthResetPasswordUserNotFound());
      } else {
        emit(AuthFail(error: e.toString()));
      }
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await sendEmailVerificationUseCase();
      emit(AuthSendVerificationSuccess());
    } catch (e) {
      emit(AuthFail(error: e.toString()));
    }
  }

  Future<void> checkEmailVerified() async {
    try {
      final isVerified = await checkEmailVerifiedUseCase();
      emit(AuthEmailVerified(isVerified: isVerified));
    } catch (e) {
      emit(AuthFail(error: e.toString()));
    }
  }

  void clearUserData() {
    allNotes = [];
    favourites = [];
    hidden = [];
    trash = [];
    events = [];
    user = null;
    hiddenNotesPin = null;
  }
}
