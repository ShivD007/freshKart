import 'dart:async';

import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';
import 'package:http_interceptor/http_interceptor.dart';

class MyInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final String accessToken = SavePreferences.getStringPreferences(
            SharedPreferenceKeys.accessTokenKey) ??
        "";
    request.headers.addEntries([
      MapEntry(
        "Authorization",
        accessToken,
      )
    ]);

    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse({required BaseResponse response}) {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
