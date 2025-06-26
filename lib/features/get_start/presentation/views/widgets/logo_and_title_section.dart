import 'package:flutter/material.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_text_styles.dart';

class LogoAndTitleSection extends StatelessWidget {
  const LogoAndTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.appMainIcon, height: 75, width: 75),
        const SizedBox(height: 20),
        const Text("Let's Get Started!", style: AppTextStyles.welcomeHeadline),
        const SizedBox(height: 10),
        const Text("Let's dive in into your account", style: AppTextStyles.welcomeSubtitle),
      ],
    );
  }
}
