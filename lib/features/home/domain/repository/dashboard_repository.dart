import 'package:dartz/dartz.dart';
import 'package:fresh_kart/common_models/response_model.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';

abstract class DashboardRepository {
  Future<Either<DashboardEntity, Failure>> fetchDashboardItems();
}
