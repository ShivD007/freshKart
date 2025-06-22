import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/product/presentation/components/product.dart';
import 'package:fresh_kart/features/product/presentation/provider/product_provider.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView(this.categoryId, {super.key});

  final String? categoryId;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(productNotifierProvider.notifier)
          .loadProducts(categoryId: widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product View'),
        ),
        body: productState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : productState.failure != null
                ? Center(
                    child: Text(
                      'Error: ${productState.failure!.toString()}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : productState.productEntity?.isEmpty ?? true
                    ? const Center(child: Text('No data available'))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          spacing: 8,
                          runSpacing: 8,
                          children: productState.productEntity
                                  ?.map((product) => ProductWidget(
                                      direction: Axis.horizontal,
                                      name: product.name,
                                      cProduct: product,
                                      weight: product.subProducts.first.name,
                                      subProuctEntity: product.subProducts))
                                  .toList() ??
                              [],
                        )));
  }
}
