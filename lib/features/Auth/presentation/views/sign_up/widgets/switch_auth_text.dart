import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_button.dart';

class SwitchAuthText extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const SwitchAuthText({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(normalText, style: AppTextStyles.semiBold16),
        CustomTextButton(
          text: actionText,
          onPressed: onTap,
        ),
      ],
    );
  }
}
