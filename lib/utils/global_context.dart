import 'package:flutter/widgets.dart';

class GlobalContext {
  GlobalContext._();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;
}
