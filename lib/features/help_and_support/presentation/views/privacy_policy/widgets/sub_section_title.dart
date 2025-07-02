 import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';

class SubSectionTitle extends StatelessWidget {
  final String text;

  const SubSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(text, style: AppTextStyles.semiBold16),
    );
  }
}
