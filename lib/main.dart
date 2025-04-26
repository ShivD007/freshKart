import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/routes/app_routes.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/global_context.dart';
import 'package:fresh_kart/utils/shared_preference_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SavePreferences.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? accessToken;
  @override
  void initState() {
    accessToken = SavePreferences.getStringPreferences(
        SharedPreferenceKeys.accessTokenKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: GlobalContext.navigatorKey,
      initialRoute: accessToken != null ? Routes.home : Routes.loginScreen,
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
