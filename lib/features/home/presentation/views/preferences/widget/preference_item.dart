import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';

class PreferenceItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const PreferenceItem({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparentColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.white70Color,
                ),
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white54Color,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
