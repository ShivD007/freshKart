import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/data/model/product_model.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class ProductDataSource {
  Future<Either<List<ProductEntity>, Failure>> getProducts(
      String? categoryId) async {
    try {
      final result = await BaseApiCallHelper.get(
          AppUrls.products + "?categoryId=$categoryId");
      final List<dynamic> data = result["data"]["products"];

      final products = data
          .map((item) =>
              ProductModel.fromJson(item as Map<String, dynamic>).toEntity())
          .toList();

      return Left(products);
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(TypeErrorException(e.toString()));
      }
    }
  }

  Future<Either<ProductEntity, Failure>> getProductById(String id) async {
    try {
      final result = await BaseApiCallHelper.get("${AppUrls.products}/$id");
      return Left(ProductModel.fromJson(result["data"]["products"]).toEntity());
    } catch (e) {
      if (e is Failure) {
        return Right(e);
      } else {
        return Right(
            TypeErrorException(e.toString())); // or however you handle it
      }
    }
  }
}
