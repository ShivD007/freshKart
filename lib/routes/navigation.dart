import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator._();
  static dynamic pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static Future<dynamic> pushTo(BuildContext context, String routeName,
      {dynamic arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<dynamic> pushReplacement(BuildContext context, String routeName,
      {dynamic arguments}) {
    return Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);
  }

  static Future<dynamic> pushAndPopUntil(BuildContext context,
      {required String routeName,
      required String popUntilRoute,
      dynamic arguments}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, routeName, ModalRoute.withName(popUntilRoute));
  }

  static Future<void> popUntil(BuildContext context, String popUntil) async {
    return Navigator.popUntil(context, ModalRoute.withName(popUntil));
  }
}
