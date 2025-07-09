import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.icon,
    this.isLeftIcon,
  });

  final IconData? icon;
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final bool? isLeftIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width ?? double.infinity,
          height: height ?? 47,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor:
                  onPressed == null
                      ? AppColors.primaryColor.withValues(alpha: 0.3)
                      : backgroundColor ?? AppColors.primaryColor,
              foregroundColor: textColor ?? AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null && isLeftIcon == true)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      icon,
                      color:
                          onPressed == null
                              ? AppColors.grayColor
                              : AppColors.whiteColor,
                      size: 22,
                    ),
                  ),
                Text(
                  text,
                  style: AppTextStyles.semiBold18.copyWith(
                    fontSize: fontSize ?? 17,
                    letterSpacing: -0.50,
                    color:
                        onPressed == null
                            ? AppColors.grayColor
                            : AppColors.whiteColor,
                  ),
                ),
                if (icon != null && isLeftIcon == false)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      icon,
                      color:
                          onPressed == null
                              ? AppColors.grayColor
                              : AppColors.whiteColor,
                      size: 22,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
