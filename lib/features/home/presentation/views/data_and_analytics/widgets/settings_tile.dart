import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool? isDanger;

  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDanger,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.semiBold16.copyWith(
                        color:
                            isDanger != null && isDanger!
                                ? AppColors.lightRedColor
                                : AppColors.white70Color,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(subtitle, style: AppTextStyles.regular14Grey),
                  ],
                ),
              ),
              SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white54Color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
