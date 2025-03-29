import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/data/datasource/user_data_source.dart';
import 'package:fresh_kart/features/user/data/model/login_req_model.dart';
import 'package:fresh_kart/features/user/data/model/refresh_token_req_model.dart';
import 'package:fresh_kart/features/user/data/model/register_user_model.dart';
import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';

class UserRepoImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepoImpl({required this.userDataSource});
  @override
  Future<Either<UserEntity, Failure>> login(LoginReqEntity entity) {
    LoginReqModel model = LoginReqModel.fromEntity(entity);
    return userDataSource.login(model);
  }

  @override
  Future<Either<UserEntity, Failure>> refreshToken(
      RefreshTokenReqEntity entity) {
    RefreshTokenReqModel model = RefreshTokenReqModel.fromEntity(entity);
    return userDataSource.refreshToken(model);
  }

  @override
  Future<Either<ResponseModel, Failure>> registerUser(
      RegisterUserEntity entity) {
    RegisterUserReqModel model = RegisterUserReqModel.fromEntity(entity);
    return userDataSource.register(model);
  }
}
