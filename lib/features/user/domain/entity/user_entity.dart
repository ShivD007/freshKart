class UserEntity {
  final String fullName;
  final String email;
  final String phoneNo;
  String? address;
  final String accessToken;
  final String refreshToken;
  final String id;

  UserEntity({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      address: map['address'],
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNo': phoneNo,
      'address': address,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      "id": id,
    };
  }
}
