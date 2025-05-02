import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/category/presentation/components/category_card.dart';
import 'package:fresh_kart/features/category/presentation/providers/category_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: categoriesState.isLoading!
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : categoriesState.error != null
              ? Center(
                  child: Text(
                    'Error: ${categoriesState.error!.toString()}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: categoriesState.categories
                            ?.map(
                                (category) => CategoryCard(category: category))
                            .toList() ??
                        [],
                  )),
    );
  }
}
