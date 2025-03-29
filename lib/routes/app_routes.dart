import 'package:flutter/material.dart';
import 'package:fresh_kart/features/user/presentation/view/login_view.dart';
import 'package:fresh_kart/routes/route_name.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic>? getRoutes(RouteSettings setting) {
    switch (setting.name) {
      case Routes.loginScreen:
        // in case if we want to send an argument then we can use
        // setting.arguments  and then pass the value to Screen constructors

        MaterialPageRoute(builder: (context) => const LoginPage());
        break;
      default:
        break;
    }
    return null;
  }
}
