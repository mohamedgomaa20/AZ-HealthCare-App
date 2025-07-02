import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';

class UpgradeProfileCard extends StatelessWidget {
  const UpgradeProfileCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.whiteColor.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        ),
        child: Row(
          children: [
             Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.workspace_premium,
                color: Colors.white,
                size: 20,
              ),
            ),

            SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upgrade Plan Now!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Enjoy all the benefits and explore more possibilities',

                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
