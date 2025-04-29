import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String? address;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
  });

  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      phoneNo: phoneNo,
      id: id,
      address: address,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["fullName"],
      email: json["email"],
      phoneNo: json["phoneNo"].toString(),
      address: json["address"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      id: json["id"],
    );
  }
}
