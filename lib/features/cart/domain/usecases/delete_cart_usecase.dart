import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/cart/domain/repository/cart_repository.dart';

class DeleteCartUsecase {
  final CartRepository _cartRepository;

  DeleteCartUsecase(this._cartRepository);

  Future<Either<ResponseModel, Failure>> call(String itemId) async {
    return await _cartRepository.removeFromCart(itemId);
  }
}
