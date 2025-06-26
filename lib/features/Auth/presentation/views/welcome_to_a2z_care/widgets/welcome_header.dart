import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_text_styles.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.appMainIcon, height: 150),
        const SizedBox(height: 15),
        Text(
          'Welcome to A2Z Care!',
          style: AppTextStyles.bold24,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Before we begin, please provide us with some personal information to ensure accurate monitoring.',
          style: AppTextStyles.semiBold16.copyWith(
            color: AppColors.grayColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
