import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';

class AgreeWithActionText extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const AgreeWithActionText({
    super.key,
    required this.value,
    required this.onChanged,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
          checkColor: Colors.white,
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
              children: [
                TextSpan(text: normalText),
                TextSpan(
                  text: actionText,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.redColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
