import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';

class CheckEmailVerifiedUseCase {
  final AuthRepository repository;

  CheckEmailVerifiedUseCase({required this.repository});

  Future<bool> call() {
    return repository.checkEmailVerified();
  }
}
