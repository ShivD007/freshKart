import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/entity/add_to_cart_req_entity.dart';
import 'package:fresh_kart/features/cart/domain/repository/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository _cartRepository;

  AddToCartUsecase(this._cartRepository);

  Future<Either<ResponseModel, Failure>> call(
      AddToCartReqEntity reqEntity) async {
    return await _cartRepository.addToCart(reqEntity);
  }
}
