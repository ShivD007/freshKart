import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

class UserModel {
  final String fullName;
  final String email;
  final String phoneNo;
  final String address;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.phoneNo,
      required this.address});

  UserEntity toEntity() {
    return UserEntity(
        fullName: fullName, email: email, phoneNo: phoneNo, address: address);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json["fullName"],
        email: json["email"],
        phoneNo: json["phoneNo"],
        address: json["address"]);
  }
}
