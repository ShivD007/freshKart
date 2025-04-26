import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/data/datasource/dashboard_datasource.dart';
import 'package:fresh_kart/features/home/data/repository/dashboard_repo_impl.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/domain/repository/dashboard_repository.dart';
import 'package:fresh_kart/features/home/domain/usecase/get_dashboard_usecase.dart';

final dashboardDatasourceProvider = Provider<DashboardDatasource>((ref) {
  return DashboardDatasource();
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final dashboardDatasource = ref.read(dashboardDatasourceProvider);
  return DashboardRepoImpl(dashboardDatasource: dashboardDatasource);
});

final getDashboardProvider = Provider<GetDashboardUsecase>((ref) {
  final dashboardRepository = ref.read(dashboardRepositoryProvider);
  return GetDashboardUsecase(dashboardRepository: dashboardRepository);
});

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final getDashboardUsecase = ref.read(getDashboardProvider);
  return DashboardNotifier(getDashboardUsecase);
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  final GetDashboardUsecase getDashboardUsecase;
  DashboardNotifier(
    this.getDashboardUsecase,
  ) : super(DashboardState());

  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, error: null);

    final Either<DashboardEntity, Failure> result = await getDashboardUsecase();
    result.fold(
      (dashboard) => state = state.copyWith(isLoading: false, data: dashboard),
      (failure) => state = state.copyWith(isLoading: false, error: failure),
    );
  }
}

class DashboardState {
  final bool isLoading;
  final DashboardEntity? data;
  final Failure? error;

  DashboardState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  DashboardState copyWith({
    bool? isLoading,
    DashboardEntity? data,
    Failure? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}
