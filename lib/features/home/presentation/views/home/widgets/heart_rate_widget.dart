import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_images.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/last_seen_status.dart';
import 'package:flutter/material.dart';

import 'heart_rate_information_dialog.dart';

class HeartRateWidget extends StatelessWidget {
  const HeartRateWidget({
    super.key,
    this.status = "Normal",
    this.numDBP = 80,
    this.numSPB = 120,
  });

  final String status;
  final int numDBP;
  final int numSPB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.only(top: 10, bottom: 25, left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.fieldCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LastSeenStatus(),
              Text(
                'Heart Rate',
                style: AppTextStyles.bold24.copyWith(
                  color: AppColors.white54Color,
                  fontSize: 22,
                ),
              ),
              SizedBox(),
              IconButton(
                onPressed: () {
                  showHeartRateInformationDialog(context: context);
                },
                icon: Icon(Icons.info, color: AppColors.yellowColor, size: 32),
              ),
            ],
          ),
          Image.asset(
            status.toLowerCase() == "normal"
                ? AppImages.hearRateGood
                : AppImages.heartRateNotGood,
            width: 180,
            height: 180,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "SBP: $numSPB/120",
                style: AppTextStyles.semiBold16.copyWith(
                  color:
                      status.toLowerCase() == "normal"
                          ? AppColors.greenColor
                          : AppColors.redColor,
                ),
              ),
              Text(
                "DBP: $numDBP/80",
                style: AppTextStyles.semiBold16.copyWith(
                  color:
                      status.toLowerCase() == "normal"
                          ? AppColors.greenColor
                          : AppColors.redColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Status: $status",
            style: AppTextStyles.semiBold16.copyWith(
              color:
                  status.toLowerCase() == "normal"
                      ? AppColors.greenColor
                      : AppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}
