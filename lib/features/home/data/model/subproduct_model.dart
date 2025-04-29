import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';

class SubProuctModel {
  final String id;
  final String description;
  final String name;
  final double mrp;
  final double discount;
  final double priceAfterDiscount;
  final List<String> images;

  SubProuctModel({
    required this.id,
    required this.name,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
    required this.images,
    required this.description,
  });

  SubProuctEntity toEntity() {
    return SubProuctEntity(
      id: id,
      name: name,
      mrp: mrp,
      discount: discount,
      priceAfterDiscount: priceAfterDiscount,
      images: images,
      description: description,
    );
  }

  factory SubProuctModel.fromEntity(SubProuctEntity entity) {
    return SubProuctModel(
      id: entity.id,
      name: entity.name,
      mrp: entity.mrp,
      discount: entity.discount,
      priceAfterDiscount: entity.priceAfterDiscount,
      images: entity.images,
      description: entity.description,
    );
  }

  factory SubProuctModel.fromJson(Map<String, dynamic> json) {
    return SubProuctModel(
      id: json['_id'],
      name: json['name'],
      mrp: json['mrp'].toDouble(),
      discount: json['discount'].toDouble(),
      priceAfterDiscount: json['priceAfterDiscount'].toDouble(),
      images: List<String>.from(json['images']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mrp': mrp,
      'discount': discount,
      'priceAfterDiscount': priceAfterDiscount,
      'images': images,
      'description': description,
    };
  }
}
