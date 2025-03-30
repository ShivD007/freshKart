import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/core/save_preference.dart';
import 'package:fresh_kart/routes/app_routes.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/global_context.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SavePreferences.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: GlobalContext.navigatorKey,
      initialRoute: Routes.loginScreen,
      onGenerateRoute: AppRoutes.getRoutes,
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
