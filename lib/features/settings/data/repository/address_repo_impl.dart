import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/settings/data/datasource/update_address_data_source.dart';
import 'package:fresh_kart/features/settings/data/models/update_address_req_model.dart';
import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';
import 'package:fresh_kart/features/settings/domain/repository/address_repo.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';

class AddressRepoImpl implements AddressRepo {
  final UpdateAddressDataSource addressDataSource;

  AddressRepoImpl({required this.addressDataSource});
  @override
  Future<Either<UserEntity, Failure>> updateAddress(
      UpdateAddressReqEntity entity) {
    final UpdateAddressReqModel reqModel =
        UpdateAddressReqModel.fromEntity(entity);
    return addressDataSource.updateAddress(reqModel);
  }
}
