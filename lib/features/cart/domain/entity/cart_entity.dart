class CartEntity {
  final List<CartProduct> products;
  final num mrp;
  final num discount;
  final num priceAfterDiscount;

  CartEntity({
    required this.products,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
  });

  factory CartEntity.fromJson(Map<String, dynamic> json) {
    return CartEntity(
      products: List<CartProduct>.from(
          json['products'].map((x) => CartProduct.fromJson(x))),
      mrp: json['mrp'],
      discount: json['discount'],
      priceAfterDiscount: json['priceAfterDiscount'],
    );
  }
}

class CartProduct {
  final String id;
  final String productId;
  final Variant variant;
  final String association;
  final num quantity;
  final num mrp;
  final num discount;
  final num priceAfterDiscount;
  final String createdAt;
  final String updatedAt;

  CartProduct({
    required this.id,
    required this.productId,
    required this.variant,
    required this.association,
    required this.quantity,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['_id'],
      productId: json['productId'],
      variant: Variant.fromJson(json['variant']),
      association: json['association'],
      quantity: json['quantity'],
      mrp: json['mrp'],
      discount: json['discount'],
      priceAfterDiscount: json['priceAfterDiscount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Variant {
  final String name;
  final String description;
  final num mrp;
  final num discount;
  final num priceAfterDiscount;
  final List<String> images;
  final String id;
  final String createdAt;
  final String updatedAt;

  Variant({
    required this.name,
    required this.description,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
    required this.images,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      name: json['name'],
      description: json['description'],
      mrp: json['mrp'],
      discount: json['discount'],
      priceAfterDiscount: json['priceAfterDiscount'],
      images: List<String>.from(json['images']),
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
