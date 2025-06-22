import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/cart/presentation/components/cart_list.dart';
import 'package:fresh_kart/features/cart/presentation/provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      body: cart.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : cart.errorMessage != null
              ? Center(
                  child: Text(
                    'Error: ${cart.errorMessage?.toString()}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : cart.cartEntity?.products.isEmpty ?? true
                  ? const Center(child: Text('No items in the cart'))
                  : CartProductList(cart: cart.cartEntity!),
    );
  }
}
