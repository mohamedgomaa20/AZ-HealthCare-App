import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatelessWidget {
  static const routeName = "onBoardingView";

  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: OnBoardingViewBody(),
    );
  }
}
