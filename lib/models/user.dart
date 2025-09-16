class UserInfoData {
  final String image = 'assets/images/person.jpg';
  final String name;
  final String email;

  UserInfoData({
    required this.name,
    required this.email,
  });

  factory UserInfoData.fromJson(json) {
    return UserInfoData(
      name: json['FullName'] ?? 'no data found',
      email: json['email'] ?? 'no data found',
    );
  }
}
