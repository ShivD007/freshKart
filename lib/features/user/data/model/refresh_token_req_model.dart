import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';

class RefreshTokenReqModel {
  late String refreshToken;
  late String email;

  RefreshTokenReqModel({required this.refreshToken, required this.email});

  Map toJson() {
    Map<String, dynamic> data = {};
    data["refreshToken"] = refreshToken;
    data["email"] = email;
    return data;
  }

  factory RefreshTokenReqModel.fromEntity(RefreshTokenReqEntity entity) {
    return RefreshTokenReqModel(
        refreshToken: entity.refreshToken, email: entity.email);
  }
}
