import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';

class SendEmailVerificationUseCase {
  final AuthRepository repository;

  SendEmailVerificationUseCase({required this.repository});

  Future<void> call() {
    return repository.sendEmailVerification();
  }
}
