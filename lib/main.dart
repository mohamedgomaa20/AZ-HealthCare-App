import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/features/account_setup_screen.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_colors.dart';
import 'features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(AZHealthCareApp());
}

class AZHealthCareApp extends StatelessWidget {
  const AZHealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),

      // onGenerateRoute: (settings) => onGenerateRoute(settings),
      // initialRoute: SplashView.routeName,
    home: AccountSetupScreen(),

    );
  }
}
