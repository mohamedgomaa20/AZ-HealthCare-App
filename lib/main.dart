import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/features/account_setup_screen.dart';
import 'package:az_health_care/shared/my_bloc_observer.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_colors.dart';
import 'features/splash/presentation/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  runApp(AZHealthCareApp());
}

class AZHealthCareApp extends StatelessWidget {
  const AZHealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      darkTheme: ThemeData(
          brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
        )
      ),

      onGenerateRoute: (settings) => onGenerateRoute(settings),
      initialRoute: SplashView.routeName,

      // home: AccountSetupScreen(),
    );
  }
}
