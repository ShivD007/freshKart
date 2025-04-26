import 'package:dartz/dartz.dart';
import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';
import 'package:fresh_kart/features/settings/domain/repository/address_repo.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

import '../../../../core/apiservices/app_exceptions.dart';

class AddressUseCase {
  final AddressRepo addressRepo;

  AddressUseCase({required this.addressRepo});

  Future<Either<UserEntity, Failure>> call(UpdateAddressReqEntity entity) {
    return addressRepo.updateAddress(entity);
  }
}
