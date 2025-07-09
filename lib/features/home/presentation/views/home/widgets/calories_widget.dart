import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../step_tracker_v2/manager/step_tracker_cubit/step_tracker_cubit.dart';
import '../../../../../step_tracker_v2/manager/step_tracker_cubit/step_tracker_state.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepTrackerCubit, StepTrackerState>(
      builder: (context, state) {
        int calories = BlocProvider.of<StepTrackerCubit>(context).caloriesTarget;
        if (state is StepTrackerLoaded) {
          final progressPercent = (((state.todayData?.caloriesBurned ?? 0) / calories) * 100).clamp(0, 100);

          return Container(
            margin: const EdgeInsets.all(8),
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
                          style: AppTextStyles.semiBold16,
                        ),
                        Text(
                          '${state.todayData?.caloriesBurned ?? 0} / $calories',
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
                  value: progressPercent / 100,
                  color: AppColors.lightPink,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: AppColors.backgroundArrowColor,
                  minHeight: 15,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${progressPercent.toStringAsFixed(1)}% Complete',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}