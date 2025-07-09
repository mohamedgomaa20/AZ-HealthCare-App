import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'core/helper_functions/on_generate_routes.dart';
import 'core/services/cache_helper.dart';
import 'core/services/my_bloc_observer.dart';
import 'core/theme/app_theme.dart';
import 'features/Account/manager/app_settings_cubit/app_settings_cubit.dart';
import 'features/Account/manager/app_settings_cubit/app_settings_state.dart';
import 'features/Auth/manger/register_cubit/register_cubit.dart';
import 'features/home/data/enums/enums.dart';
import 'features/home/manager/personal_info_cubit/personal_info_cubit.dart';
import 'features/onboarding_profile_setup/manager/emergency_contacts_cubit/emergency_contacts_cubit.dart';
import 'features/onboarding_profile_setup/manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import 'features/onboarding_profile_setup/manager/sensor_upload_cubit/sensor_upload_cubit.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'package:path/path.dart';

import 'features/step_tracker_v2/manager/step_tracker_cubit/step_tracker_cubit.dart';
import 'features/water_tracker/manager/water_tracking_cubit/water_tracking_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  // await requestNotificationPermission();
  // await NotificationService.initialize();
  await _requestInitialPermissions();
  final dbPath = await getDatabasesPath();
  print("📦 Database Path: $dbPath");

  final exists = await databaseExists(join(dbPath, 'step_tracker.db'));
  print("📦 Database exists? $exists");

  DioHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SensorUploadCubit()),
        BlocProvider(create: (context) => AppSettingsCubit()),
        BlocProvider(create: (context) => EmergencyContactsCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => OnboardingProfileSetupCubit()),
        BlocProvider(create: (context) => PersonalInfoCubit()..fetchUserData()),
        BlocProvider(create: (context) => WaterTrackingCubit()..loadData()),
        BlocProvider(
          create: (context) => StepTrackerCubit()..initializeStepTracker(),
        ),
      ],
      child: AZHealthCareApp(),
    ),
  );
}

Future<void> _requestInitialPermissions() async {
  final status = await Permission.activityRecognition.request();

  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
}

class AZHealthCareApp extends StatelessWidget {
  const AZHealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(399, 888),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:
                  state.themeMode == AppThemeMode.system
                      ? ThemeMode.system
                      : (state.themeMode == AppThemeMode.dark
                          ? ThemeMode.dark
                          : ThemeMode.light),
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
              onGenerateRoute: (settings) => onGenerateRoute(settings),
              initialRoute: SplashView.routeName,
              // initialRoute: OnboardingProfileSetupView.routeName,
            );
          },
        );
      },
    );
  }
}
