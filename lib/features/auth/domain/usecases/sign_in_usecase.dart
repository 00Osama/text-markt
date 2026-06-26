import 'package:text_markt/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
