import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fresh_kart/core/apiservices/api_helper.dart';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/features/home/data/model/dashboard_model.dart';
import 'package:fresh_kart/features/home/domain/entity/dashboard_entity.dart';
import 'package:fresh_kart/utils/app_urls.dart';

class DashboardDatasource {
  Future<Either<DashboardEntity, Failure>> fetchDashboardData() async {
    try {
      final result = await BaseApiCallHelper.get(AppUrls.dashboardUrl);

      return Left(DashboardModel.fromJson(result["data"]).toEntity());
    } catch (e) {
      return Right(TypeErrorException(e.toString()));
    }
  }
}
