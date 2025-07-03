import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class SocialAccountTile extends StatelessWidget {
  final Widget icon;
  final String platformName;
  final bool isLinked;
  final VoidCallback onTap;

  const SocialAccountTile({
    super.key,
    required this.icon,
    required this.platformName,
    required this.isLinked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        color: AppColors.blueGrayBackground2,
        child: InkWell(
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                SizedBox(width: 45, child: icon),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(
                    platformName,
                    style: AppTextStyles.semiBold18.copyWith(
                      color: AppColors.white70Color,
                    ),
                  ),
                ),
                Text(
                  isLinked ? 'Linked' : 'Link',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isLinked ? Colors.white54 : const Color(0xFFFF4757),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
