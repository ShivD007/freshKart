import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/routes/app_routes.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/global_context.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SavePreferences.init();
  final String? accessToken =
      SavePreferences.getStringPreferences(SharedPreferenceKeys.accessTokenKey);
  runApp(ProviderScope(child: MyApp(accessToken: accessToken)));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.accessToken});
  final String? accessToken;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: GlobalContext.navigatorKey,
      initialRoute:
          accessToken != null ? Routes.dashboardScreen : Routes.loginScreen,
      onGenerateRoute: (settings) => AppRoutes.getRoutes(settings),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: child ?? const SizedBox.shrink());
      },
    );
  }
}
