import 'package:az_health_care/core/utils/app_images.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 32,
            height: 32,

            child: Image.asset(AppImages.appMainIcon),
          ),
          Text(
            'A2Z Care',
            style: AppTextStyles.bold24.copyWith(color: AppColors.darkGray),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[600],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.redLight, AppColors.redDark],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Get Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(AppImages.proIcon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
