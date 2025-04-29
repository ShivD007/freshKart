import 'package:fresh_kart/features/home/data/model/category_model.dart';
import 'package:fresh_kart/features/home/data/model/offer_model.dart';
import 'package:fresh_kart/features/home/data/model/product_model.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';

class DashboardModel {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<OfferModel> offers;

  DashboardModel({
    required this.categories,
    required this.products,
    required this.offers,
  });

  DashboardEntity toEntity() {
    return DashboardEntity(
      categories: categories.map((category) => category.toEntity()).toList(),
      products: products.map((product) => product.toEntity()).toList(),
      offers: offers.map((offer) => offer.toEntity()).toList(),
    );
  }

  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      categories: entity.categories
          .map((category) => CategoryModel.fromEntity(category))
          .toList(),
      products: entity.products
          .map((product) => ProductModel.fromEntity(product))
          .toList(),
      offers:
          entity.offers.map((offer) => OfferModel.fromEntity(offer)).toList(),
    );
  }
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      categories: List<CategoryModel>.from(
          json['categories'].map((x) => CategoryModel.fromJson(x))),
      products: List<ProductModel>.from(
          json['products'].map((x) => ProductModel.fromJson(x))),
      offers: List<OfferModel>.from(
          json['offers'].map((x) => OfferModel.fromJson(x))),
    );
  }
}
