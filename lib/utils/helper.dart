import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/user/domain/entity/user_entity.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/app_constants.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static void showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents user from dismissing the dialog
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text("Loading...",
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showBottomSheet(BuildContext context,
      {required Widget child,
      bool isScrollControlled = true,
      bool isDismissible = true}) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: child,
      ),
    );
  }

  static void openDialer(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle error
    }
  }

  static void logout(BuildContext context) async {
    SavePreferences.clearAKey(SharedPreferenceKeys.refreshTokenKey);
    SavePreferences.clearAKey(SharedPreferenceKeys.accessTokenKey);
    SavePreferences.clearAKey(SharedPreferenceKeys.userInfo);

    CustomNavigator.popUntil(context, "//");
    CustomNavigator.pushTo(context, Routes.loginScreen);
  }

  static saveLoginDetails(UserEntity userEntity) {
    SavePreferences.saveStringPreferences(
        SharedPreferenceKeys.refreshTokenKey, userEntity.refreshToken!);
    SavePreferences.saveStringPreferences(
        SharedPreferenceKeys.accessTokenKey, userEntity.accessToken!);

    SavePreferences.saveStringPreferences(
        SharedPreferenceKeys.userInfo, jsonEncode(userEntity.toJson()));
  }
}
