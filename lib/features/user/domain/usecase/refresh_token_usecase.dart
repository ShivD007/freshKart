import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';

class RefreshTokenUsecase {
  final UserRepository userRepository;

  RefreshTokenUsecase({required this.userRepository});

  Future<Either<UserEntity, Failure>> call(RefreshTokenReqEntity entity) {
    return userRepository.refreshToken(entity);
  }
}
