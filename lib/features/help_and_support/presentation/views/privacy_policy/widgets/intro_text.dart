 import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to A2Z Care, the health and wellness app designed to help you monitor your heart rate, blood pressure, blood sugar, weight, and more. Your privacy is important to us, and this Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application, A2Z Care (the "App").',
      style: AppTextStyles.semiBold16.copyWith(color: AppColors.white70Color),
    );
  }
}
