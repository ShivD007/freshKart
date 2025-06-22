import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';

class ProductEntity {
  final String id;
  final String name;
  final CategoryEntity category;
  final List<SubProductEntity> subProducts;
  final SubProductEntity frequentlyBought;

  ProductEntity({
    required this.category,
    required this.id,
    required this.name,
    required this.subProducts,
    required this.frequentlyBought,
  });
}

class SubProductEntity {
  final String id;
  final String description;
  final String name;
  final double mrp;
  final double discount;
  final double priceAfterDiscount;
  final List<String> images;

  SubProductEntity({
    required this.description,
    required this.id,
    required this.name,
    required this.images,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
  });
}
