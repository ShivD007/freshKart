import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';

class RegisterUserModel {
  late String email;
  late String password;

  RegisterUserModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["email"] = email;
    data["password"] = password;
    return data;
  }

  factory RegisterUserModel.fromEntity(RegisterUserEntity entity) {
    return RegisterUserModel(email: entity.email, password: entity.password);
  }
}
