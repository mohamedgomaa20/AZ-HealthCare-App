// import 'package:flutter/material.dart';
//
// import 'features/onboarding_profile_setup/presentation/views/widgets/onboarding_profile_setup_view_body.dart'; // سنقوم بإنشاء هذا الملف
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Account Setup',
//       debugShowCheckedModeBanner: false, // لإزالة شارة الـ Debug
//       theme: ThemeData(
//         brightness: Brightness.dark, // تفعيل الـ Dark Mode للتطبيق بالكامل
//         primaryColor: const Color(0xFFFE2B54), // اللون الأحمر الأساسي
//         hintColor: const Color(0xFFFE2B54), // لتلوين الـ TextField وغيره
//         scaffoldBackgroundColor: const Color(0xFF1E1E1E), // خلفية داكنة
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.transparent, // لجعل الـ AppBar شفاف
//           elevation: 0, // إزالة الظل
//           iconTheme: IconThemeData(color: Colors.white), // لون الأيقونات في الـ AppBar
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(color: Colors.white),
//           bodyMedium: TextStyle(color: Colors.white70),
//           headlineLarge: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//           headlineMedium: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//           titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFFFE2B54), // لون زر "Continue"
//             foregroundColor: Colors.white, // لون النص داخل الزر
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         // يمكن إضافة المزيد من السمات هنا لتناسب التصميم تمامًا
//       ),
//       home: const AccountSetupFlow(),
//     );
//   }
// }

import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
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
      theme: ThemeData(
        brightness: Brightness.light,
        // تفعيل الـ Dark Mode للتطبيق بالكامل
        primaryColor: const Color(0xFFFE2B54),
        // اللون الأحمر الأساسي
        hintColor: const Color(0xFFFE2B54),
        // لتلوين الـ TextField وغيره
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        // خلفية داكنة
        // scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          // لجعل الـ AppBar شفاف
          elevation: 0,
          // إزالة الظل
          iconTheme: IconThemeData(color: Colors.white),
          // لون الأيقونات في الـ AppBar
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE2B54),
            // لون زر "Continue"
            foregroundColor: Colors.white,
            // لون النص داخل الزر
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
      ),

      onGenerateRoute: (settings) => onGenerateRoute(settings),
      initialRoute: SplashView.routeName,
      // initialRoute: InitialUserInfoView.routeName,
    );
  }
}
