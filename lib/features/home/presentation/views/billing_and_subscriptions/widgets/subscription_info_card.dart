import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../upgrade/presentation/views/upgrade_plan/upgrade_plan_view.dart';

class SubscriptionInfoCard extends StatelessWidget {
  const SubscriptionInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime expirationDate = DateTime(today.year + 1, today.month, today.day);

    String formattedDate = DateFormat('MMM dd, yyyy').format(expirationDate);

    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Your subscription will expire on $formattedDate.',
            style: AppTextStyles.semiBold18,
          ),
          SizedBox(height: 5.0), // Space between lines
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Renew or cancel your subscription ',
                style: AppTextStyles.semiBold18,
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UpgradePlanView()),
                  );
                },
                child: Text(
                  'here.',
                  style: AppTextStyles.bold18.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
