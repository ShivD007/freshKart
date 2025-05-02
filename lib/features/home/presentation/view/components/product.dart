import 'package:flutter/material.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/utils/helper.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(
      {super.key,
      required this.name,
      required this.weight,
      required this.subProuctEntity,
      required this.direction});
  final String name;
  final String weight;
  final List<SubProuctEntity> subProuctEntity;

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: direction == Axis.horizontal ? double.maxFinite : 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
                direction: direction,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: subProuctEntity.isEmpty
                            ? NoImagePlaceholder()
                            : subProuctEntity.first.images.isEmpty
                                ? NoImagePlaceholder()
                                : Image.network(
                                    subProuctEntity.first.images.first,
                                    height: direction == Axis.horizontal
                                        ? 150
                                        : 100,
                                    width: direction == Axis.horizontal
                                        ? 150
                                        : null,
                                    fit: BoxFit.fill,
                                  ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: IconButton(
                            icon: const Icon(Icons.add_shopping_cart,
                                size: 16, color: Colors.black),
                            onPressed: () {
                              Helper.showBottomSheet(context,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: subProuctEntity
                                        .map((product) => ListTile(
                                              leading: product.images.isEmpty
                                                  ? null
                                                  : Image.network(
                                                      product.images.first,
                                                      height: 80,
                                                      width: 80,
                                                    ),
                                              title: Text(product.name),
                                              subtitle:
                                                  Text("₹ ${product.mrp}"),
                                              trailing: const Icon(Icons.add),
                                            ))
                                        .toList(),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: direction == Axis.horizontal ? 16 : 0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Text("Starting from",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey)),
                        Text(weight),
                        const SizedBox(height: 8),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            "₹ ${subProuctEntity.first.priceAfterDiscount}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "₹ ${subProuctEntity.first.mrp}",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                          ),
                        ]),
                        Text(
                          "You save ₹ ${subProuctEntity.first.mrp - subProuctEntity.first.priceAfterDiscount}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.green),
                        ),
                        if (direction == Axis.horizontal)
                          Text(
                            "${subProuctEntity.first.description}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey),
                          ),
                      ],
                    ),
                  )
                ])));
  }

  Container NoImagePlaceholder() {
    return Container(
      height: 150,
      width: 150,
      color: Colors.white54,
      child: const Icon(Icons.image, size: 50),
    );
  }
}
