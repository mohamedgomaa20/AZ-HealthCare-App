import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String title;
  final String body;

  const TermsAndConditionsDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:AppColors.backgroundColor,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
         child: SingleChildScrollView(
          child: Text(body, style: const TextStyle(fontSize: 14, height: 1.5)),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: AppTextStyles.regular14.copyWith(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            "Continue",
            style: AppTextStyles.regular14.copyWith(color: AppColors.redColor),
          ),
        ),
      ],
    );
  }
}
