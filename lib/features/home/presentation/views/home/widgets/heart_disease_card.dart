import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/last_seen_status.dart';
import 'package:flutter/material.dart';

 import '../../../../manager/home_cubit/home_cubit.dart';
import 'heart_rate_information_dialog.dart';

class HeartDiseaseCard extends StatelessWidget {
  const HeartDiseaseCard({super.key, this.status = "Normal"});

  final String status;

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
                        'Heart Disease',
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

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),

                    decoration: BoxDecoration(
                      color: AppColors.greenColor.withValues(alpha: .08),
                      borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Current Status"),
                        SizedBox(height: 5),
                        Text(
                          status,
                          style: AppTextStyles.bold20.copyWith(
                            color:
                                status.toLowerCase() == "normal"
                                    ? AppColors.greenColor
                                    : AppColors.redColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 10),

                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Last Minute Analysis",
                              style: AppTextStyles.medium14.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.analytics_sharp,
                              color: AppColors.grayColor,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StatusOfLastAnalysis(status: "Normal"),
                            ),
                            Expanded(
                              child: StatusOfLastAnalysis(
                                status: "Supraventicular",
                                color: AppColors.redColor.withValues(alpha: .2),
                              ),
                            ),
                            Expanded(
                              child: StatusOfLastAnalysis(
                                status: "Premature",
                                color: AppColors.redColor.withValues(alpha: .2),
                              ),
                            ),
                            Expanded(
                              child: StatusOfLastAnalysis(
                                status: "Fusion",
                                color: AppColors.redColor.withValues(alpha: .2),
                              ),
                            ),
                            Expanded(
                              child: StatusOfLastAnalysis(
                                status: "Unclassifiavle",
                                color: AppColors.redColor.withValues(alpha: .2),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class StatusOfLastAnalysis extends StatelessWidget {
  const StatusOfLastAnalysis({super.key, required this.status, this.color});

  final String status;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: SizedBox(
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14Grey.copyWith(fontSize: 14),
            ),

            Container(
              height: 22,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: color ?? AppColors.greenColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
