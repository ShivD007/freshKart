import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/category/data/datasource/category_data_source.dart';
import 'package:fresh_kart/features/category/domain/repository/category_repo.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryDataSource dataSource;

  CategoryRepoImpl({required this.dataSource});

  @override
  Future<Either<List<CategoryEntity>, Failure>> getCategories() async =>
      dataSource.getCategories();
}
