import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/category/presentation/components/category_card.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';
import 'package:fresh_kart/features/product/presentation/components/product.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  DashboardEntity? dashboardEntity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    return Scaffold(
        body: dashboardState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : dashboardState.error != null
                ? Center(
                    child: Text(
                      'Error: ${dashboardState.error!.toString()}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                : dashboardState.data == null
                    ? const Center(child: Text('No data available'))
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: dashboardState.data!.offers
                                        .map((offer) => _buildPromoCard(
                                            offer.name, offer.description))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Novelties of the week',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          CustomNavigator.pushTo(
                                              context, Routes.products);
                                        },
                                        child: const Text('See all'),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: dashboardState.data!.products
                                        .map((product) => ProductWidget(
                                              direction: Axis.vertical,
                                              cProduct: product,
                                              name: product.name,
                                              subProuctEntity:
                                                  product.subProducts,
                                              weight: product
                                                  .subProducts[0].name
                                                  .toString(),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Categories',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          CustomNavigator.pushTo(
                                              context, Routes.categories);
                                        },
                                        child: const Text('See all'),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: dashboardState.data!.categories
                                        .map((category) =>
                                            CategoryCard(category: category))
                                        .toList(),
                                  ),
                                ),
                              ]),
                        ),
                      ));
  }
}

Widget _buildPromoCard(String name, String description) {
  return Container(
    width: 300, // set a fixed width for horizontal scrolling
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[200],
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('1,300 bonuses'),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    ),
  );
}
