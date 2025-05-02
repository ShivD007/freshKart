import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<List<ProductEntity>, Failure>> fetchProducts();
  Future<Either<ProductEntity, Failure>> fetchProductById(String id);
}
