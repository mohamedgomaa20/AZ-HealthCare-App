import 'package:az_health_care/core/helper_functions/on_generate_routes.dart';
import 'package:flutter/material.dart';

import 'features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(AZHealthCareApp());
}

class AZHealthCareApp extends StatelessWidget {
  const AZHealthCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      onGenerateRoute: (settings) => onGenerateRoute(settings),
      initialRoute: SplashView.routeName,
    );
  }
}

// import 'package:az_health_care/modules/login/login_screen.dart';
// import 'package:az_health_care/shared/styles/constants.dart';
// import 'package:az_health_care/shared/cubit/cubit.dart';
// import 'package:az_health_care/shared/cubit/states.dart';
// import 'package:az_health_care/shared/my_bloc_observer.dart';
// import 'package:az_health_care/shared/network/local/cache_helper.dart';
// import 'package:az_health_care/shared/network/remote/dio_helper/dio_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'layout/cubit/cubit.dart';
// import 'layout/app_layout.dart';
// import 'modules/on_boarding/on_boarding_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Bloc.observer = MyBlocObserver();
//   await CacheHelper.init();
//   DioHelper.init();
//
//   token = CacheHelper.getData(key: 'token');
//   print('==================token=================');
//   print(token);
//   print('========================================');
//   bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
//   bool? fromShared = CacheHelper.getBool(key: 'isDark');
//   Widget widget;
//
//   Widget startWidget() {
//     if (onBoarding != null) {
//       if (token != null) {
//         widget = HomeLayout();
//       } else {
//         widget = LoginScreen();
//       }
//     } else {
//       widget = OnBoardingScreen();
//     }
//     return widget;
//   }
//
//   runApp(MyApp(isDark: fromShared, startWidget: startWidget()));
// }
//
// class MyApp extends StatelessWidget {
//   final bool? isDark;
//
//   // final bool? onBoarding;
//   final Widget startWidget;
//
//   MyApp({super.key, required this.isDark, required this.startWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => AppCubit()..changeAppMode(fromShared: isDark),
//         ),
//
//         BlocProvider(
//           create:
//               (context) =>
//                   ShopCubit()
//                     ..getHomeData()
//                     ..getUserData(),
//         ),
//       ],
//
//       child: BlocConsumer<AppCubit, AppStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//
//             theme: ThemeData(inputDecorationTheme: InputDecorationTheme()),
//             themeMode: ThemeMode.light,
//             // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
//             home: startWidget,
//             // (onBoarding ?? false) ? ShopLoginScreen() : OnBoardingScreen(),
//             // home: ShopHomeLayoutScreen(),
//           );
//         },
//       ),
//     );
//   }
// }
