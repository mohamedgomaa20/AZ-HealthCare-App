import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class CustomIndicator extends StatelessWidget {
  const CustomIndicator(
      {super.key , required this.count, required this.pageController});

   final int count;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: ExpandingDotsEffect(
        expansionFactor: 4,
        spacing: 5.0,
        dotWidth: 10.0,
        dotHeight: 10.0,
        dotColor: AppColors.primaryColor.withOpacity(.3),
        activeDotColor: AppColors.primaryColor,
      ),
    );
  }
}
