import 'package:dartz/dartz.dart';
import 'package:fresh_kart/features/category/domain/repository/category_repo.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';
import '../../../../core/apiservices/app_exceptions.dart';

class CategoryUseCase {
  final CategoryRepo categoryRepo;
  CategoryUseCase({required this.categoryRepo});
  Future<Either<List<CategoryEntity>, Failure>> call() {
    return categoryRepo.getCategories();
  }
}
