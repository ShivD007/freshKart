import 'package:flutter/foundation.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';
import 'package:fresh_kart/features/home/domain/entity/offer_entity.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';

class DashboardEntity {
  List<CategoryEntity> categories;
  List<ProductEntity> products;
  List<OfferEntity> offers;

  DashboardEntity({
    required this.categories,
    required this.products,
    required this.offers,
  });
}
