import 'package:flutter/material.dart';
import 'package:fresh_kart/features/home/domain/entity/category_entity.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.pushTo(context, Routes.products,
            arguments: category.id);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 24,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  category.image,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
