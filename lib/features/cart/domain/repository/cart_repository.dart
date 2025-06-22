import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/entity/add_to_cart_req_entity.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';
import 'package:fresh_kart/features/cart/domain/entity/delete_cart_item_req_entity.dart';

abstract class CartRepository {
  Future<Either<CartEntity, Failure>> getCart();
  Future<Either<ResponseModel, Failure>> addToCart(AddToCartReqEntity item);
  Future<Either<ResponseModel, Failure>> removeFromCart(String itemId);
  Future<Either<ResponseModel, Failure>> updateCartItemQuantity(
      UpdateCartItemReqEntity cartDetail);
}
