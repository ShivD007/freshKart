import 'dart:async';
import 'dart:convert';

import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/user/domain/entity/refresh_token_req_entity.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/features/user/domain/usecase/refresh_token_usecase.dart';
import 'package:fresh_kart/utils/app_constants.dart';
import 'package:fresh_kart/utils/helper.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';
import 'package:http_interceptor/http_interceptor.dart';

class ExpiredTokenRetryPolicy implements RetryPolicy {
  final RefreshTokenUsecase refreshTokenUsecase;

  ExpiredTokenRetryPolicy({required this.refreshTokenUsecase});

  @override
  Duration delayRetryAttemptOnException({required int retryAttempt}) {
    return Duration.zero;
  }

  @override
  Duration delayRetryAttemptOnResponse({required int retryAttempt}) {
    return Duration.zero;
  }

  @override
  int get maxRetryAttempts => AppConstants.maxRetryCount;

  @override
  FutureOr<bool> shouldAttemptRetryOnException(
      Exception reason, BaseRequest request) {
    return true;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    bool retry = false;

    if (response is Response) {
      if (response.statusCode == 401) {
        final String userJson = SavePreferences.getStringPreferences(
                SharedPreferenceKeys.userInfo) ??
            "{}";
        final UserEntity user = UserEntity.fromMap(jsonDecode(userJson));
        final String? refreshToken = SavePreferences.getStringPreferences(
            SharedPreferenceKeys.refreshTokenKey);
        final refreshTokenReqEntity = RefreshTokenReqEntity(
            refreshToken: refreshToken!, email: user.email);
        final refreshTokenUseCaseResult =
            await refreshTokenUsecase(refreshTokenReqEntity);

        refreshTokenUseCaseResult.fold((result) {
          Helper.saveLoginDetails(result);
          retry = true;
        }, (failure) {
          retry = false;
        });
      }
    }

    return retry;
  }
}
