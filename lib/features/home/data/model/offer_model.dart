import 'package:fresh_kart/features/home/data/model/product_model.dart';
import 'package:fresh_kart/features/home/domain/entity/offer_entity.dart';

class OfferModel {
  final String id;
  final String name;
  final String description;
  final List<ProductModel>
      products; // Assuming products are represented by their IDs
  final double discount;

  OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.products,
    required this.discount,
  });

  OfferEntity toEntity() {
    return OfferEntity(
      id: id,
      name: name,
      description: description,
      products: products.map((product) => product.toEntity()).toList(),
      discount: discount,
    );
  }

  factory OfferModel.fromEntity(OfferEntity entity) {
    return OfferModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      products: entity.products
          .map((product) => ProductModel.fromEntity(product))
          .toList(),
      discount: entity.discount,
    );
  }

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      products: List<ProductModel>.from(json['products']),
      discount: json['discount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'products': products,
      'discount': discount,
    };
  }
}
