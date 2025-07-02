import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:az_health_care/core/services/my_bloc_observer.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_colors.dart';
import 'features/home/presentation/views/home/home_view.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.primaryColor,
        // scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          titleTextStyle: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.whiteColor),
          bodyMedium: TextStyle(color: AppColors.white70Color),
          headlineLarge: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white10Color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
          ),
        ),
      ),

      onGenerateRoute: (settings) => onGenerateRoute(settings),
      // initialRoute: SplashView.routeName,
      initialRoute: HomeLayout.routeName,
    );
  }
}
