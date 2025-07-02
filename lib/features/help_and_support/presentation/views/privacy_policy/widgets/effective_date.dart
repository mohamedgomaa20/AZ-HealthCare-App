 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class EffectiveDate extends StatelessWidget {
  const EffectiveDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        'Effective Date: ${DateFormat('MMMM d yyyy').format(DateTime.now())}',
        style: AppTextStyles.bold24.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}
