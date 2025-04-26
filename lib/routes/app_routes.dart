import 'package:flutter/material.dart';
import 'package:fresh_kart/features/home/presentation/view/home_view.dart';
import 'package:fresh_kart/features/user/presentation/view/login_view.dart';
import 'package:fresh_kart/features/user/presentation/view/registration_view.dart';
import 'package:fresh_kart/routes/route_name.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic>? getRoutes(RouteSettings setting) {
    switch (setting.name) {
      case Routes.loginScreen:
        // in case if we want to send an argument then we can use
        // setting.arguments  and then pass the value to Screen constructors

        return MaterialPageRoute(builder: (context) => const LoginPage());

      case Routes.registerationScreen:
        return MaterialPageRoute(builder: (context) => RegistrationPage());

      case Routes.home:
        return MaterialPageRoute(builder: (context) => HomeView());

      default:
        break;
    }
    return null;
  }
}
