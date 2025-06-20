import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/entity/delete_cart_item_req_entity.dart';
import 'package:fresh_kart/features/cart/domain/repository/cart_repository.dart';

class UpdateCartUsecase {
  final CartRepository _cartRepository;

  UpdateCartUsecase(this._cartRepository);

  Future<Either<ResponseModel, Failure>> call(
      UpdateCartItemReqEntity cartEntity) {
    return _cartRepository.updateCartItemQuantity(cartEntity);
  }
}
