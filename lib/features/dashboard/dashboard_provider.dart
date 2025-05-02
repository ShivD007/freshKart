import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/features/home/presentation/provider/home_provider.dart';
import 'package:fresh_kart/features/settings/presentation/providers/setting_provider.dart'
    as sp;

final currentViewProvider =
    StateNotifierProvider<CurrentViewProvider, int>((ref) {
  final settingProviders = ref.read(sp.settingProvider.notifier);
  final homeProvider = ref.read(dashboardNotifierProvider.notifier);
  return CurrentViewProvider(0,
      settingProvider: settingProviders, dashboardNotifier: homeProvider);
});

class CurrentViewProvider extends StateNotifier<int> {
  final sp.UserNotifier settingProvider;
  final DashboardNotifier dashboardNotifier;
  CurrentViewProvider(super.state,
      {required this.settingProvider, required this.dashboardNotifier});

  void onChange(int index) {
    state = index;
    switch (state) {
      case 0:
        dashboardNotifier.loadDashboard();
        break;
      case 1:
      case 2:
      default:
    }
  }
}
