import 'package:flutter/material.dart';

import '../../../../../../../core/constants.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';

class SelectedPaymentCard extends StatelessWidget {
  final String paymentMethod;

  const SelectedPaymentCard({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Payment Method',
          style: AppTextStyles.bold18.copyWith(color: AppColors.whiteColor),
        ),

        SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.blueGrayBackground2,
            borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFeb001b),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'MC',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(paymentMethod, style: AppTextStyles.bold20),
                    SizedBox(height: 4),
                    Text(
                      '**** **** **** 4679',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Change',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
