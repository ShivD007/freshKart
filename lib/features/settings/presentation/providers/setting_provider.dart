// ------------------- Riverpod Provider -------------------
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/settings/data/datasource/update_address_data_source.dart';
import 'package:fresh_kart/features/settings/data/models/address_model.dart';
import 'package:fresh_kart/features/settings/data/repository/address_repo_impl.dart';
import 'package:fresh_kart/features/settings/domain/entity/update_address_req_entity.dart';
import 'package:fresh_kart/features/settings/domain/repository/address_repo.dart';
import 'package:fresh_kart/features/settings/domain/usecase/address_use_case.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/utils/helper.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';

final dataSourceProvider = Provider<UpdateAddressDataSource>((ref) {
  return UpdateAddressDataSource();
});

final repoProvider = Provider<AddressRepo>((ref) {
  final dataSource = ref.read(dataSourceProvider);
  return AddressRepoImpl(addressDataSource: dataSource);
});

final useCaseProvider = Provider<AddressUseCase>((ref) {
  final repo = ref.read(repoProvider);
  return AddressUseCase(addressRepo: repo);
});

final settingProvider =
    NotifierProvider<UserNotifier, UserEntity>(UserNotifier.new);

class UserNotifier extends Notifier<UserEntity> {
  @override
  UserEntity build() {
    final String userJson =
        SavePreferences.getStringPreferences(SharedPreferenceKeys.userInfo) ??
            "{}";
    final UserEntity user = UserEntity.fromMap(jsonDecode(userJson));

    return user;
  }

  Future<void> updateAddress(
      String newAddress, String pincode, String alternativeMobileNo,
      {required VoidCallback onComplete, required BuildContext context}) async {
    Helper.showLoaderDialog(context);
    final result = await ref.read(useCaseProvider)(UpdateAddressReqEntity(
      address: newAddress,
      userId: state.id,
      alternateMobileNo: alternativeMobileNo,
      pincode: pincode,
    ));
    CustomNavigator.pop(context);
    result.fold((user) {
      state = state.copyWith(
        address: AddressModel(
          address: newAddress,
          pincode: pincode,
          alternateMobileNo: alternativeMobileNo,
        ),
      );
      SavePreferences.saveStringPreferences(
          SharedPreferenceKeys.userInfo, jsonEncode(user.toJson()));

      onComplete();
    }, (failure) {
      AlertMessage.show(failure.toString());
    });
  }
}
