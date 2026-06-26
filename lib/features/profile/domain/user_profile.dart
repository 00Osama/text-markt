class UserProfile {
  final String image = 'assets/images/person.png';
  final String name;
  final String email;

  UserProfile({required this.name, required this.email});

  factory UserProfile.fromJson(json) {
    return UserProfile(
      name: json['FullName'] ?? 'no data found',
      email: json['email'] ?? 'no data found',
    );
  }
}
