import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';

class CartProductList extends ConsumerWidget {
  final CartEntity cart;

  const CartProductList({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: cart.products.length,
      itemBuilder: (context, index) {
        final product = cart.products[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Image.network(
              product.variant.images.first,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(product.variant.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "₹${product.priceAfterDiscount} (Discount: ₹${product.discount})"),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _updateQuantity(ref, product, -1),
                    ),
                    Text('${product.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _updateQuantity(ref, product, 1),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteProduct(ref, product),
            ),
          ),
        );
      },
    );
  }

  void _updateQuantity(WidgetRef ref, CartProduct product, int change) {}

  void _deleteProduct(WidgetRef ref, CartProduct product) {}
}
