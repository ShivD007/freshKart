import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/category/presentation/components/category_card.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/domain/entity/product_entity.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/helper.dart';

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
    Future.microtask(() {
      ref.read(dashboardNotifierProvider.notifier).loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.location_on),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Express delivery',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text('Deepolie Street, 42',
                style: Theme.of(context).textTheme.bodyLarge),
          ]),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            switch (value) {
              case 0:
                // CustomNavigator.pushTo(context, Routes.home);
                break;
              case 1:
                // CustomNavigator.pushTo(context, Routes.cart);
                break;
              case 2:
                CustomNavigator.pushReplacement(context, Routes.loginScreen);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: '',
            ),
          ],
        ),
        body: dashboardState.isLoading
            ? const CircularProgressIndicator()
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
                        Text("Strating from",
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
