import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_markt/features/profile/data/models/user_profile_model.dart';
import 'package:text_markt/features/profile/domain/entities/user_profile.dart';

class ProfileRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ProfileRemoteDataSource({required this.auth, required this.firestore});

  Future<UserProfile> getUserProfile() async {
    final response = await firestore
        .collection('users')
        .doc(auth.currentUser!.email)
        .get();

    return UserProfileModel.fromFirestore(response);
  }
}
