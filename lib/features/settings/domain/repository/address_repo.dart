import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

abstract class AddressRepo {
  Future<Either<UserEntity, Failure>> updateAddress(
      UpdateAddressReqEntity entity);
}
