import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/upgrade/presentation/views/upgrade_plan/widgets/pricing_header.dart';
 import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';
 import 'features_fist.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.isMonthly,
  });

  final bool isMonthly;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          decoration: BoxDecoration(
            color: AppColors.blueGrayBackground2,
            borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          ),
          child: Column(
            children: [
              PricingHeader(isMonthly: isMonthly),
              SizedBox(height: 30),

              Divider(endIndent: 10, indent: 10),
              SizedBox(height: 20),

              FeaturesList(),
            ],
          ),
        ),
        if (!isMonthly)
          Positioned(
            right: 0,
            top: 0,

            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(kPrimaryBorderRadius),
                  bottomLeft: Radius.circular(kPrimaryBorderRadius),
                ),
              ),
              child: Text(
                'Save 16%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
