class UserEntity {
  final String fullName;
  final String email;
  final String phoneNo;
  final String? address;
  final String accessToken;
  final String refreshToken;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.accessToken,
    required this.refreshToken,
  });
}
