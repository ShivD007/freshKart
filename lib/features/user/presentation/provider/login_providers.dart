import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/settings/presentation/components/update_address_component.dart';
import 'package:fresh_kart/features/user/data/datasource/user_data_source.dart';
import 'package:fresh_kart/features/user/data/repository/user_repo_impl.dart';
import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';
import 'package:fresh_kart/features/user/domain/usecase/login_usecase.dart';
import 'package:fresh_kart/features/user/domain/usecase/refresh_token_usecase.dart';
import 'package:fresh_kart/features/user/domain/usecase/register_usecase.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/helper.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';
import 'package:riverpod/riverpod.dart';

final userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSource();
});

final userRepoProvider = Provider<UserRepository>((ref) {
  final datasource = ref.read(userDataSourceProvider);
  return UserRepoImpl(userDataSource: datasource);
});

final loginUserProvider = Provider<LoginUsecase>((ref) {
  final repo = ref.read(userRepoProvider);
  return LoginUsecase(userRepository: repo);
});
final refreshTokenProvider = Provider<RefreshTokenUsecase>((ref) {
  final repo = ref.read(userRepoProvider);
  return RefreshTokenUsecase(userRepository: repo);
});

final registerUserProvider = Provider<RegisterUserUseCase>((ref) {
  final repo = ref.read(userRepoProvider);
  return RegisterUserUseCase(userRepository: repo);
});

final userNotifierProviders =
    NotifierProvider<UserNotifier, void>(UserNotifier.new);

class UserNotifier extends Notifier {
  late RegisterUserUseCase registerUserUseCase;
  late LoginUsecase loginUseCase;
  late RefreshTokenUsecase refreshTokenUsecase;

  @override
  build() {
    registerUserUseCase = ref.read(registerUserProvider);
    loginUseCase = ref.read(loginUserProvider);
    refreshTokenUsecase = ref.read(refreshTokenProvider);
  }

  Future<void> login(BuildContext context, LoginReqEntity loginEntity) async {
    Helper.showLoaderDialog(context);
    final result = await loginUseCase(loginEntity);

    result.fold(
      (result) {
        CustomNavigator.pop(context);

        if (result.address == null) {
          Helper.showBottomSheet(context,
              isDismissible: false, child: const UpdateAddressComponent());
        } else {
          SavePreferences.saveStringPreferences(
              SharedPreferenceKeys.refreshTokenKey, result.refreshToken);
          SavePreferences.saveStringPreferences(
              SharedPreferenceKeys.accessTokenKey, result.accessToken);
          SavePreferences.saveStringPreferences(
              SharedPreferenceKeys.userInfo, jsonEncode(result.toJson()));

          CustomNavigator.pushReplacement(
            context,
            Routes.home,
          );
        }
      },
      (failure) {
        CustomNavigator.pop(context);
        if (failure.response?["data"]?["NON"] == 1) {
          CustomNavigator.pushTo(context, Routes.registerationScreen);
        }
        AlertMessage.show(failure.toString());
      },
    );
  }
}
