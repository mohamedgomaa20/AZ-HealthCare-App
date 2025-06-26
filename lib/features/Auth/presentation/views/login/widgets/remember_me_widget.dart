import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_button.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({super.key});

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: (val) {
                setState(() {
                  isRememberMe = val!;
                });
              },
              checkColor: Colors.white,
              activeColor: AppColors.primaryColor,
            ),
            const SizedBox(width: 4),
            Text("Remember me", style: AppTextStyles.semiBold16),
          ],
        ),
        CustomTextButton(text: "Forgot Password?", onPressed: () {}),
      ],
    );
  }
}
