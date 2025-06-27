import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_button.dart';
import '../../forget_password/forgot_password_view.dart';

class RememberMeAndForgetPasswordRow extends StatelessWidget {
  const RememberMeAndForgetPasswordRow({
    super.key,
    required this.isRememberMe,
    required this.onRememberMeChanged,
  });

  final bool isRememberMe;

  final Function(bool?)? onRememberMeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: onRememberMeChanged,
              checkColor: Colors.white,
              activeColor: AppColors.primaryColor,
            ),
            const SizedBox(width: 4),
            Text("Remember me", style: AppTextStyles.semiBold16),
          ],
        ),
        CustomTextButton(text: "Forgot Password?", onPressed: () {
          Navigator.pushNamed(context, ForgotPasswordView.routeName);

        }),
      ],
    );
    ;
  }
}
