import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_app_bar.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/cart/presentation/view/cart_screen.dart';
import 'package:fresh_kart/features/dashboard/dashboard_provider.dart';
import 'package:fresh_kart/features/home/presentation/view/home_view.dart';
import 'package:fresh_kart/features/settings/presentation/view/settings_view.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  PageController controller = PageController();
  late UserEntity user;

  @override
  void initState() {
    super.initState();
    final String userJson =
        SavePreferences.getStringPreferences(SharedPreferenceKeys.userInfo) ??
            "{}";
    user = UserEntity.fromMap(jsonDecode(userJson));
  }

  @override
  Widget build(BuildContext context) {
    final viewProvider = ref.read(currentViewProvider.notifier);
    final viewProviderWatcher = ref.watch(currentViewProvider);

    return Scaffold(
        appBar: CustomAppBar(
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Express delivery',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
            Text(
              user.address?.address ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            )
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            controller.jumpToPage(value);
            viewProvider.onChange(value);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: viewProviderWatcher == 0 ? Colors.blue : Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: viewProviderWatcher == 1 ? Colors.blue : Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: viewProviderWatcher == 2 ? Colors.blue : Colors.black,
              ),
              label: '',
            ),
          ],
        ),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeView(),
            CartScreen(),
            SettingsView(),
          ],
        ));
  }
}
