import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';

class OfferEntity {
  final String id;
  final String name;
  final String description;
  final List<ProductEntity> products;
  final double discount;

  OfferEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.products,
    required this.discount,
  });
}
