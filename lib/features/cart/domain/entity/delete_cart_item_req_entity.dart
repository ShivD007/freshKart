class UpdateCartItemReqEntity {
  // cartId, productId, variantId, quantity

  String cartId;
  String productId;
  String variantId;
  int quantity;
  UpdateCartItemReqEntity({
    required this.cartId,
    required this.productId,
    required this.variantId,
    required this.quantity,
  });
  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productId': productId,
      'variantId': variantId,
      'quantity': quantity,
    };
  }
}
