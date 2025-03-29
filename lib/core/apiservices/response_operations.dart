import 'dart:convert';
import 'dart:developer';
import 'package:fresh_kart/core/apiservices/app_exceptions.dart';
import 'package:fresh_kart/utils/app_strings.dart';
import 'package:http/http.dart';

class ResponseOperation {
  static dynamic returnResponse(Response response) {
    // to handle html content in case of server down
    if (response.headers["content-type"]?.contains('text/html') ?? false) {
      throw FetchDataException(AppStrings.somethingNotRight);
    } else {
      switch (response.statusCode) {
        case 200:
        case 201:
          final responseJson = json.decode(response.body);
          return responseJson;
        case 406:
          throw BadRequestException(
              jsonDecode(response.body)["message"], json.decode(response.body));
        case 401:
          // after 2 unsuccessful retry to refresh token, we do logout the user
          //TODO:// logout
          throw UnauthorisedException(AppStrings.sessionExpired);
        case 403:
          throw UnauthorisedException(
              jsonDecode(response.body)["message"], json.decode(response.body));
        case 404:
          throw NotFoundException(jsonDecode(response.body)["message"]);
        case 408:
          throw LimitExceededException(jsonDecode(response.body)["message"]);
        case 500:
        default:
          throw FetchDataException(jsonDecode(response.body)["message"]);
      }
    }
  }
}
