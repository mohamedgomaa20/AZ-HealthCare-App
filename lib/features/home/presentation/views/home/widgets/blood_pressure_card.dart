import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_images.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/last_seen_status.dart';
import 'package:flutter/material.dart';

import '../../../../manager/home_cubit/home_cubit.dart';
import 'heart_rate_information_dialog.dart';

class BloodPressureCard extends StatelessWidget {
  const BloodPressureCard({
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
    var cubit = HomeCubit.get(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.only(top: 10, bottom: 25, left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.fieldCardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child:
          cubit.valueOfSwitch
              ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LastSeenStatus(),
                      Text(
                        'Blood Pressure',
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
                        icon: Icon(
                          Icons.info,
                          color: AppColors.yellowColor,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    status.toLowerCase() == "normal"
                        ? AppImages.bloodPressure
                        : AppImages.bloodPressureProblem,
                    width: 180,
                    height: 180,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "DBP: $numSPB/120",
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
              )
              : Center(
                child: Text(
                  "Tracking Off",
                  style: AppTextStyles.semiBold18.copyWith(
                    color: AppColors.grayColor,
                  ),
                ),
              ),
    );
  }
}
