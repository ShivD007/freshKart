import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/settings/data/models/update_address_req_model.dart';
import 'package:fresh_kart/features/user/data/model/user_model.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class UpdateAddressDataSource {
  Future<Either<UserEntity, Failure>> updateAddress(
      UpdateAddressReqModel reqModel) async {
    try {
      final result =
          await BaseApiCallHelper.put(AppUrls.addressUrl, reqModel.toJson());
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
}
