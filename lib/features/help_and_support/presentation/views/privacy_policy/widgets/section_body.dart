 import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class SectionBody extends StatelessWidget {
  final String text;

  const SectionBody(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.semiBold16.copyWith(color: AppColors.white70Color),
    );
  }
}
