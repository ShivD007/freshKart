class AddToCartReqEntity {
  final String productId;
  final String variantId;
  final int quantity;

  AddToCartReqEntity({
    required this.productId,
    required this.variantId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'variantId': variantId,
      'quantity': quantity,
    };
  }
}
