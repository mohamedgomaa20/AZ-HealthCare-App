import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class BuildMenuItem extends StatelessWidget {
  const BuildMenuItem({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.leadingIconColor,
    this.trailingWidget,
    this.verticalPadding,
    this.hasArrow,
    this.titleColor,
  });

  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? leadingIconColor;
  final Color? titleColor;
  final Widget? trailingWidget;
  final double? verticalPadding;
  final bool? hasArrow;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding ?? 18,
          ),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color:
                      leadingIconColor ?? Colors.white.withValues(alpha: 0.8),
                  size: 24,
                ),
              if (icon != null) SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: titleColor ?? AppColors.white70Color,
                  ),
                ),
              ),
              if (trailingWidget != null) trailingWidget!,
              if (trailingWidget != null) SizedBox(width: 5),
              if (hasArrow == true)
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
