import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/domain/repository/dashboard_repository.dart';

class GetDashboardUsecase {
  final DashboardRepository dashboardRepository;

  GetDashboardUsecase({required this.dashboardRepository});

  Future<Either<DashboardEntity, Failure>> call() async {
    return await dashboardRepository.fetchDashboardItems();
  }
}
