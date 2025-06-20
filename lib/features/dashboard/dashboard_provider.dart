import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/cart/presentation/provider/cart_provider.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';
import 'package:fresh_kart/features/settings/presentation/providers/setting_provider.dart'
    as sp;

final currentViewProvider =
    StateNotifierProvider<CurrentViewProvider, int>((ref) {
  final settingProviders = ref.read(sp.settingProvider.notifier);
  final homeProvider = ref.read(dashboardNotifierProvider.notifier);
  final cartProviders = ref.read(cartProvider.notifier);
  return CurrentViewProvider(0,
      settingProvider: settingProviders,
      dashboardNotifier: homeProvider,
      cartNotifier: cartProviders);
});

class CurrentViewProvider extends StateNotifier<int> {
  final sp.UserNotifier settingProvider;
  final DashboardNotifier dashboardNotifier;
  final CartNotifier cartNotifier;
  CurrentViewProvider(super.state,
      {required this.settingProvider,
      required this.dashboardNotifier,
      required this.cartNotifier}) {
    Future.microtask(() {
      onChange(0);
    });
  }

  void onChange(int index) {
    state = index;
    switch (state) {
      case 0:
        dashboardNotifier.loadDashboard();
        break;
      case 1:
        cartNotifier.getCart();
        break;
      case 2:
      default:
    }
  }
}
