class ProductEntity {
  final String id;
  final String name;
  final String categoryId;
  final List<SubProuctEntity> subProducts;
  final SubProuctEntity frequentlyBought;

  ProductEntity({
    required this.categoryId,
    required this.id,
    required this.name,
    required this.subProducts,
    required this.frequentlyBought,
  });
}

class SubProuctEntity {
  final String id;
  final String description;
  final String name;
  final double mrp;
  final double discount;
  final double priceAfterDiscount;
  final List<String> images;

  SubProuctEntity({
    required this.description,
    required this.id,
    required this.name,
    required this.images,
    required this.mrp,
    required this.discount,
    required this.priceAfterDiscount,
  });
}
