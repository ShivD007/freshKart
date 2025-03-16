import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<UserEntity, Failure>> registerUser(RegisterUserEntity entity);
  Future<Either<UserEntity, Failure>> refreshToken(
      RefreshTokenReqEntity entity);
  Future<Either<UserEntity, Failure>> login(LoginReqEntity entity);
}
