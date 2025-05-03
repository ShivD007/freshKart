import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/data/model/login_req_model.dart';
import 'package:fresh_kart/features/user/data/model/refresh_token_req_model.dart';
import 'package:fresh_kart/features/user/data/model/register_user_model.dart';
import 'package:fresh_kart/features/user/data/model/user_model.dart';
import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class UserDataSource {
  Future<Either<UserEntity, Failure>> login(LoginReqModel reqModel) async {
    try {
      final result =
          await BaseApiCallHelper.post(AppUrls.loginUrl, reqModel.toJson());
      return Left(UserModel.fromJson(result["data"]).toEntity());
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(
            TypeErrorException(e.toString())); // or however you handle it
      }
    }
  }

  Future<Either<UserEntity, Failure>> refreshToken(
      RefreshTokenReqModel reqModel) async {
    // try {
    final result =
        await BaseApiCallHelper.post(AppUrls.refreshToken, reqModel.toJson());
    return Left(UserModel.fromJson(result["data"]).toEntity());
    // } catch (e) {
    //   if (e is Failure) {
    //     return Right(e);
    //   } else {
    //     return Right(
    //         TypeErrorException(e.toString())); // or however you handle it
    //   }
    // }
  }

  Future<Either<ResponseModel, Failure>> register(
      RegisterUserReqModel reqModel) async {
    try {
      final Map<String, dynamic> result =
          await BaseApiCallHelper.post(AppUrls.registerUrl, reqModel.toJson());
      return Left(ResponseModel.fromJson(result));
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(
            TypeErrorException(e.toString())); // or however you handle it
      }
    }
  }
}
