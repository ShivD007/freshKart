import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';
import 'package:fresh_kart/features/cart/domain/repository/cart_repository.dart';

class GetCartUsecase {
  final CartRepository _cartRepository;

  GetCartUsecase(this._cartRepository);

  Future<Either<CartEntity, Failure>> call() async {
    return await _cartRepository.getCart();
  }
}
