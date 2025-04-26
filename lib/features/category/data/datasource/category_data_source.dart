import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/data/model/category_model.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class CategoryDataSource {
  Future<Either<List<CategoryEntity>, Failure>> getCategories() async {
    try {
      final result = await BaseApiCallHelper.get(AppUrls.categories);
      return Left(
          result["data"].map((e) => CategoryModel.fromJson(e).toEntity()));
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
