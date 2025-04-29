import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/core/apiservices/interceptors/expiry_retry_mechanism.dart';
import 'package:fresh_kart/core/apiservices/interceptors/interceptor.dart';
import 'package:fresh_kart/core/apiservices/response_operations.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/features/user/data/datasource/user_data_source.dart';
import 'package:fresh_kart/features/user/data/repository/user_repo_impl.dart';
import 'package:fresh_kart/features/user/domain/repository/user_repository.dart';
import 'package:fresh_kart/features/user/domain/usecase/refresh_token_usecase.dart';
import 'package:fresh_kart/features/user/presentation/provider/login_providers.dart';
import 'package:fresh_kart/utils/app_strings.dart';
import 'package:fresh_kart/utils/app_urls.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';
import 'package:http/http.dart' as https;
import 'package:http_interceptor/http/intercepted_client.dart';

class BaseApiCallHelper {
  static const String _baseUrl = AppUrls.baseUrl;

  static Map<String, String> getHeaders() {
    final String? accessToken = SavePreferences.getStringPreferences(
        SharedPreferenceKeys.accessTokenKey);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': accessToken.toString()
    };
    if (accessToken == null) header.remove("Authorization");
    return header;
  }

  static https.Client http(logoutOnUnAuthorizedStatus) {
    final UserDataSource userDataSource = UserDataSource();
    UserRepository userRepository =
        UserRepoImpl(userDataSource: userDataSource);

    return InterceptedClient.build(
      retryPolicy: logoutOnUnAuthorizedStatus
          ? ExpiredTokenRetryPolicy(
              refreshTokenUsecase:
                  RefreshTokenUsecase(userRepository: userRepository))
          : null,
      interceptors: [MyInterceptor()],
    );
  }

  static Future<dynamic> get(String url,
      {Map<String, String>? header,
      bool? logoutOnUnAuthorizedStatus = true}) async {
    Map<String, String> tempHeader = {...getHeaders(), ...header ?? {}};

    try {
      final response = await http(logoutOnUnAuthorizedStatus)
          .get(Uri.parse(_baseUrl + url), headers: tempHeader);
      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e.runtimeType == Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }

  static Future<dynamic> post(String url, Object? body,
      {Map<String, String>? header,
      bool? logoutOnUnAuthorizedStatus = true}) async {
    Map<String, String> tempHeader = {...getHeaders(), ...header ?? {}};

    try {
      final response = await http(logoutOnUnAuthorizedStatus).post(
          Uri.parse(_baseUrl + url),
          body: jsonEncode(body),
          headers: tempHeader);
      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }

  static Future<dynamic> put(String url, Object? body,
      {bool? logoutOnUnAuthorizedStatus = true}) async {
    try {
      final response = await http(logoutOnUnAuthorizedStatus).put(
          Uri.parse(_baseUrl + url),
          body: jsonEncode(body),
          headers: getHeaders());

      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e.runtimeType == Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }

  static Future<dynamic> delete(String url, Object? body,
      {Map<String, dynamic>? header,
      bool? logoutOnUnAuthorizedStatus = true}) async {
    Map<String, String> tempHeader = {...getHeaders(), ...header ?? {}};

    try {
      final response = await http(logoutOnUnAuthorizedStatus).delete(
          Uri.parse(_baseUrl + url),
          body: jsonEncode(body),
          headers: tempHeader);
      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e.runtimeType == Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }

  // with custom header  and without authorzation
  static Future<dynamic> postWithoutAuthorization(String url, Object? body,
      {required Map<String, String> header}) async {
    header['Content-Type'] = 'application/json';
    try {
      final response = await https.post(Uri.parse(_baseUrl + url),
          body: jsonEncode(body), headers: header);
      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e.runtimeType == Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }

  static Future<dynamic> getWithoutAuthorization(String url,
      {required Map<String, String> header, bool appendBaseUrl = true}) async {
    header['Content-Type'] = 'application/json';

    try {
      final response = await http(false).get(
          Uri.parse((appendBaseUrl ? _baseUrl : "") + url),
          headers: header);
      return ResponseOperation.returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppStrings.internetDisConnected);
    } catch (e) {
      if (e.runtimeType == Failure) {
        rethrow;
      } else {
        throw CommonFailureException(e.toString());
      }
    }
  }
}
