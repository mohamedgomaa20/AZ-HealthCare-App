import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/core/services/my_bloc_observer.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/utils/app_colors.dart';
import 'features/home/data/enums/enums.dart';
import 'features/home/presentation/views/app_appearance/app_settings_cubit/app_settings_cubit.dart';
import 'features/home/presentation/views/app_appearance/app_settings_cubit/app_settings_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  runApp(
    BlocProvider(
      create: (_) => AppSettingsCubit(),
      child: const AZHealthCareApp(),
    ),
  );
}

class AZHealthCareApp extends StatelessWidget {
  const AZHealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode:
              state.themeMode == AppThemeMode.system
                  ? ThemeMode.system
                  : (state.themeMode == AppThemeMode.dark
                      ? ThemeMode.dark
                      : ThemeMode.light),
          theme: ThemeData.light(),
          locale:
              state.language == AppLanguage.system
                  ? null
                  : (state.language == AppLanguage.ar
                      ? const Locale('ar')
                      : const Locale('en')),

          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          darkTheme: ThemeData(
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
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.blueGrayBackground2,
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(kPrimaryBorderRadius),
                ),
                borderSide: BorderSide(color: AppColors.errorColor, width: 1.5),
              ),
            ),
          ),

          onGenerateRoute: (settings) => onGenerateRoute(settings),
          // initialRoute: SplashView.routeName,
          initialRoute: HomeLayout.routeName,
        );
      },
    );
  }
}
