import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/data/datasource/dashboard_datasource.dart';
import 'package:fresh_kart/features/home/data/model/dashboard_model.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/features/home/domain/repository/dashboard_repository.dart';

class DashboardRepoImpl extends DashboardRepository {
  final DashboardDatasource dashboardDatasource;

  DashboardRepoImpl({required this.dashboardDatasource});

  @override
  Future<Either<DashboardEntity, Failure>> fetchDashboardItems() async {
    return await dashboardDatasource.fetchDashboardData();
  }
}
