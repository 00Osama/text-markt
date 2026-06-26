import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<void> call(String email) {
    return repository.resetPassword(email);
  }
}
