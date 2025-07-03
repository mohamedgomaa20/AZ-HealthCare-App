

import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/helper_functions/on_generate_routes.dart';
import 'core/services/cache_helper.dart';
import 'core/services/my_bloc_observer.dart';
import 'core/theme/app_theme.dart';
import 'features/home/data/enums/enums.dart';
import 'features/home/presentation/views/app_appearance/app_settings_cubit/app_settings_cubit.dart';
import 'features/home/presentation/views/app_appearance/app_settings_cubit/app_settings_state.dart';
import 'features/home/presentation/views/home_layout.dart';

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
          // initialRoute: SplashView.routeName,
          initialRoute: HomeLayout.routeName,
        );
      },
    );
  }
}
