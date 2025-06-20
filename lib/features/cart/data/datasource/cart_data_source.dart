import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class CartDataSource {
  Future<Either<ResponseModel, Failure>> addItemToCart(
      Map<String, dynamic> body) async {
    try {
      final result = await BaseApiCallHelper.post(AppUrls.cartQueries, body);
      return left(ResponseModel.fromJson(result));
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(TypeErrorException(e.toString()));
      }
    }
  }

  Future<Either<ResponseModel, Failure>> updateItemToCart(
      Map<String, dynamic> body) async {
    try {
      final result = await BaseApiCallHelper.put(AppUrls.cartQueries, body);
      return left(ResponseModel.fromJson(result));
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(TypeErrorException(e.toString()));
      }
    }
  }

  Future<Either<ResponseModel, Failure>> removeItemFromCart(
      String itemId) async {
    try {
      final result = await BaseApiCallHelper.delete(
          AppUrls.cartQueries, {"cartId": itemId});
      return left(ResponseModel.fromJson(result));
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(TypeErrorException(e.toString()));
      }
    }
  }

  Future<Either<CartEntity, Failure>> getCarts() async {
    try {
      final result = await BaseApiCallHelper.get(AppUrls.cartQueries);
      return left(CartEntity.fromJson(result["data"]));
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(TypeErrorException(e.toString()));
      }
    }
  }
}
