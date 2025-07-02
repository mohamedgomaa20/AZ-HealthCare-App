import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all( 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.deepPurple, AppColors.deepPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Calories Burned',
                    style: AppTextStyles.semiBold16
                  ),

                  Text(
                    '500 / 1200',
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.local_fire_department,
                color: AppColors.whiteColor,
                size: 50,
              ),
            ],
          ),
          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: .5,
            color: AppColors.lightPink,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: AppColors.backgroundArrowColor,
            minHeight: 15,
          ),

          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              '41% Complete',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
