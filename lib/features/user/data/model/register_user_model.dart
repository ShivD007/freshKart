import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';

class RegisterUserReqModel {
  late String email;
  late String password;
  late String phoneNo;
  late String fullName;

  RegisterUserReqModel(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.phoneNo});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["email"] = email;
    data["password"] = password;
    data["phoneNo"] = phoneNo;
    data["fullName"] = fullName;
    return data;
  }

  factory RegisterUserReqModel.fromEntity(RegisterUserEntity entity) {
    return RegisterUserReqModel(
      email: entity.email,
      password: entity.password,
      phoneNo: entity.phoneNo,
      fullName: entity.fullName,
    );
  }
}
