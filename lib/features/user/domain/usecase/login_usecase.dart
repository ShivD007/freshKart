import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';

class LoginUsecase {
  final UserRepository userRepository;

  LoginUsecase({required this.userRepository});

  Future<Either<UserEntity, Failure>> call(LoginReqEntity loginEntity) {
    return userRepository.login(loginEntity);
  }
}
