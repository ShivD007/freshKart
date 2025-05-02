import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/features/product/data/datasource/product_data_source.dart';
import 'package:fresh_kart/features/product/domain/repository/product_repo.dart';

class ProductRepoImpl implements ProductRepository {
  final ProductDataSource dataSource;
  ProductRepoImpl({required this.dataSource});

  @override
  Future<Either<ProductEntity, Failure>> fetchProductById(String id) {
    return dataSource.getProductById(id);
  }

  @override
  Future<Either<List<ProductEntity>, Failure>> fetchProducts(
      String? categoryId) async {
    return dataSource.getProducts(categoryId);
  }
}
