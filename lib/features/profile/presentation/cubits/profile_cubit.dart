import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/features/profile/domain/entities/user_profile.dart';
import 'package:text_markt/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:text_markt/globals.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;

  ProfileLoaded({required this.userProfile});
}

class ProfileFail extends ProfileState {}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.getUserProfileUseCase})
    : super(ProfileInitial());

  final GetUserProfileUseCase getUserProfileUseCase;

  Future<void> getUserProfile() async {
    try {
      emit(ProfileLoading());
      user ??= await getUserProfileUseCase();
      emit(ProfileLoaded(userProfile: user!));
    } catch (e) {
      emit(ProfileFail());
    }
  }
}
