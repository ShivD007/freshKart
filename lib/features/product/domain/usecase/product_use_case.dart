import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/features/product/domain/repository/product_repo.dart';

class ProductUseCase {
  final ProductRepository productRepo;

  ProductUseCase({required this.productRepo});

  Future<Either<ProductEntity, Failure>> call(String id) async {
    return await productRepo.fetchProductById(id);
  }
}
