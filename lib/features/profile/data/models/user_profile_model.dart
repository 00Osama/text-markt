import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:text_markt/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({required super.name, required super.email});

  factory UserProfileModel.fromFirestore(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>?;

    return UserProfileModel(
      name: data?['FullName'] ?? 'no data found',
      email: data?['email'] ?? 'no data found',
    );
  }
}
