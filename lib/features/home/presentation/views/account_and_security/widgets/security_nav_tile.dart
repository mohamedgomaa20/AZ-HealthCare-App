// File: security_nav_tile.dart
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';

class SecurityNavTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDanger;

  const SecurityNavTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparentColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.blueGrayBackground2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.semiBold16.copyWith(
                        color: isDanger ? AppColors.lightRedColor : AppColors.whiteColor,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.white60Color),
                ],
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    subtitle!,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.white54Color,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
