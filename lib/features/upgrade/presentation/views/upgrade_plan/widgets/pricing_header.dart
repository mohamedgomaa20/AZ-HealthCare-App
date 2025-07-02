import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';

class PricingHeader extends StatelessWidget {
  final bool isMonthly;

  const PricingHeader({super.key, required this.isMonthly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'A2Z Care Pro',
          style: AppTextStyles.bold24.copyWith(color: AppColors.whiteColor),
        ),

        SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${isMonthly ? '9.99' : '99.99'}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                isMonthly ? '/ month' : '/ year',

                style: AppTextStyles.bold20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
