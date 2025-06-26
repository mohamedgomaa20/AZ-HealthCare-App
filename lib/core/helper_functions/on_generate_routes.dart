import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:az_health_care/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:az_health_care/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/Auth/presentation/views/login/login_view.dart';
import '../../features/Auth/presentation/views/sign_up/sign_up_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case GetStartView.routeName:
      return MaterialPageRoute(builder: (context) => const GetStartView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
