import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<Either<UserEntity, Failure>> call(RegisterUserEntity entity) {
    return userRepository.registerUser(entity);
  }
}
