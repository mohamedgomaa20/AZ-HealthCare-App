import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor = AppColors.redColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isUnderline = true;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: AppTextStyles.semiBold16.copyWith(
          color: textColor,
          decoration:
              isUnderline ? TextDecoration.underline : TextDecoration.none,
          decorationColor: AppColors.redColor,
        ),
      ),
    );
  }
}
