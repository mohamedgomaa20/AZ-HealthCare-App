import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    required this.count,
    required this.pageController,
    this.dotColor,
  });

  final int count;
  final PageController pageController;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: ExpandingDotsEffect(
        expansionFactor: 4.0,
        spacing: 5.0,
        dotWidth: 8.0,
        dotHeight: 9.0,
        dotColor: dotColor ?? AppColors.primaryColor.withValues(alpha: .1),
        activeDotColor: dotColor ?? AppColors.primaryColor,
      ),
    );
  }
}
