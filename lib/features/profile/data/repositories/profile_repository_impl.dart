import 'package:text_markt/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:text_markt/features/profile/domain/entities/user_profile.dart';
import 'package:text_markt/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfile> getUserProfile() {
    return remoteDataSource.getUserProfile();
  }
}
