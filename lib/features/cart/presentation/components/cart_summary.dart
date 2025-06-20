import 'package:flutter/material.dart';
import 'package:fresh_kart/features/cart/domain/entity/cart_entity.dart';

class CartSummary extends StatelessWidget {
  final CartEntity cart;

  const CartSummary({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("MRP: ₹${cart.mrp}", style: const TextStyle(fontSize: 16)),
              Text("Discount: ₹${cart.discount}",
                  style: const TextStyle(fontSize: 16, color: Colors.green)),
            ],
          ),
          Text("Total: ₹${cart.priceAfterDiscount}",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
