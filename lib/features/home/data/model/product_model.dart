import 'package:fresh_kart/features/home/data/model/category_model.dart';
import 'package:fresh_kart/features/home/data/model/subproduct_model.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final CategoryModel category;
  final List<SubProuctModel> subProducts;
  final SubProuctModel frequentlyBought;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.subProducts,
    required this.frequentlyBought,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      category: category.toEntity(),
      subProducts:
          subProducts.map((subProduct) => subProduct.toEntity()).toList(),
      frequentlyBought: frequentlyBought.toEntity(),
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      category: CategoryModel.fromEntity(entity.category),
      subProducts: entity.subProducts
          .map((subProduct) => SubProuctModel.fromEntity(subProduct))
          .toList(),
      frequentlyBought: SubProuctModel.fromEntity(entity.frequentlyBought),
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      category: CategoryModel.fromJson(json['category']),
      subProducts: List<SubProuctModel>.from(
          json['variants'].map((x) => SubProuctModel.fromJson(x))),
      frequentlyBought: SubProuctModel.fromJson(json['frequentVariant']),
    );
  }
}
