import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:az_health_care/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:az_health_care/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/Auth/presentation/views/all_set_password/all_set_password_view.dart';
import '../../features/Auth/presentation/views/forget_password/forgot_password_view.dart';
import '../../features/Auth/presentation/views/login/login_view.dart';
import '../../features/Auth/presentation/views/sign_up/sign_up_view.dart';
import '../../features/Auth/presentation/views/welcome_to_a2z_care/welcome_to_a2z_care_view.dart';
import '../../features/home/presentation/views/home_layout.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/home/presentation/views/notification_view.dart';
import '../../features/home/presentation/views/profile_view.dart';
import '../../features/home/presentation/views/tracker_view.dart';
import '../../features/home/presentation/views/vip_view.dart';
import '../../features/onboarding_profile_setup/presentation/views/onboarding_profile_setup_view.dart';
import '../../features/personal_info/presentation/views/personal_info_view.dart';
import '../../features/settings/presentation/views/change_password/change_password_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case GetStartView.routeName:
      return MaterialPageRoute(builder: (context) => const GetStartView());

    //auth-----------------------------
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordView(),
      );
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case PersonalInfoView.routeName:
      return MaterialPageRoute(builder: (context) => const PersonalInfoView());

    case WelcomeToA2zCareView.routeName:
      return MaterialPageRoute(
        builder: (context) => const WelcomeToA2zCareView(),
      );
    //home------------------------------
    case HomeLayout.routeName:
      return MaterialPageRoute(builder: (context) => const HomeLayout());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case VipView.routeName:
      return MaterialPageRoute(builder: (context) => const VipView());

    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case NotificationView.routeName:
      return MaterialPageRoute(builder: (context) => const NotificationView());
    case TrackerView.routeName:
      return MaterialPageRoute(builder: (context) => const TrackerView());

    ///
    case OnboardingProfileSetupView.routeName:
      return MaterialPageRoute(
        builder: (context) => const OnboardingProfileSetupView(),
      );
    // case AccountSetupFlow.routeName:
    //   return MaterialPageRoute(builder: (context) => const AccountSetupFlow());
    case AllSetPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const AllSetPasswordView(),
      );

    /// settings------------------------------
    case ChangePasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ChangePasswordView(),
      );
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
