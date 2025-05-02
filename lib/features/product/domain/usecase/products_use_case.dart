import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/features/product/domain/repository/product_repo.dart';

class ProductsUseCase {
  final ProductRepository productRepo;

  ProductsUseCase({required this.productRepo});

  Future<Either<List<ProductEntity>, Failure>> call() async {
    return await productRepo.fetchProducts();
  }
}
