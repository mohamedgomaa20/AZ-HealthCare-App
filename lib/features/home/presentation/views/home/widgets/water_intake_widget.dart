import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/cubit/water_tracking_cubit.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/cubit/water_tracking_cubit.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/cubit/water_tracking_state.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/water_tracker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../water_tracker/presentation/views/water_tracking_screen.dart';

class WaterIntakeWidget extends StatelessWidget {
  const WaterIntakeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterTrackingCubit, WaterTrackingState>(
      builder: (context, state) {
        var cubit = WaterTrackingCubit.get(context);
        final goal = cubit.goal;

        if (goal == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final progress =
        (goal.achievedAmount / goal.targetAmount).clamp(0.0, 1.0);
        final percentage = (progress * 100).toInt();

        return Container(
          height: 140,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundStepColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Water Intake', style: AppTextStyles.bold18),
                    const SizedBox(height: 10),
                    Text(
                      '${goal.achievedAmount}ml / ${goal.targetAmount}ml',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.blueDarkColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$percentage% Complete',
                      style: const TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        value: progress,
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: AppColors.backgroundLinearColor,
                        minHeight: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.water_drop, color: AppColors.blueColor, size: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaterTrackingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundArrowColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
