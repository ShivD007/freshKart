import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';

class LoginReqModel {
  late String email;
  late String password;

  LoginReqModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["email"] = email;
    data["password"] = password;
    return data;
  }

  factory LoginReqModel.fromEntity(LoginReqEntity entity) {
    return LoginReqModel(email: entity.email, password: entity.password);
  }
}
