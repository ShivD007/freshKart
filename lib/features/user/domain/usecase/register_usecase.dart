import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<Either<ResponseModel, Failure>> call(RegisterUserEntity entity) {
    return userRepository.registerUser(entity);
  }
}
