import 'package:text_markt/features/profile/domain/entities/user_profile.dart';
import 'package:text_markt/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase({required this.repository});

  Future<UserProfile> call() {
    return repository.getUserProfile();
  }
}
