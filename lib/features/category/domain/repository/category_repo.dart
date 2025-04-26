import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';

abstract class CategoryRepo {
  Future<Either<List<CategoryEntity>, Failure>> getCategories();
}
