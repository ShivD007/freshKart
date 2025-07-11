class AppUrls {
  AppUrls._();
  static const String baseUrl = "http://192.168.1.5:3000";
  static const String loginUrl = "/api/v1/users/login";
  static const String registerUrl = "/api/v1/users/register";
  static const String refreshToken = "/api/v1/generateToken";
  static const String dashboardUrl = "/api/v1/dashboard";

  static const String addressUrl = "/api/v1/address/updateAddress";
  static const String categories = "/api/v1/category/allCategories";
  static const String products = "/api/v1/product";
  static const String cartQueries = "/api/v1/cart";
}
