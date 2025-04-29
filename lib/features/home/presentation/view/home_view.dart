import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';

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
                Icons.wallet,
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
                Icons.favorite,
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
                                        onPressed: () {},
                                        child: const Text('See all'),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: dashboardState.data!.products
                                        .map((product) => _buildProductCard(
                                            product.name,
                                            product.subProducts[0].toString(),
                                            4.5.toString(),
                                            product.subProducts[0].mrp
                                                .toString()))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Flexible(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.start,
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: dashboardState.data!.categories
                                        .map((category) => _buildCategoryCard(
                                            category.name, context))
                                        .toList(),
                                  ),
                                ),
                              ]),
                        ),
                      ));
  }
}

Widget _buildProductCard(
    String name, String weight, String rating, String price) {
  return Container(
    width: 150,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border,
                        size: 16, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text(weight),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              Text(rating),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.remove, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(price, style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 4),
                  const Icon(Icons.add, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCategoryCard(String name, BuildContext context) {
  return Container(
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
              'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
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
