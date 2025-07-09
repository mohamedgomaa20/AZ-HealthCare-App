import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/sensor_data_upload_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';
 import '../../data/models/OnboardingConstants.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../widgets/DailyTargetCard.dart';
import '../widgets/custom_activity_level_tile.dart';

class HealthGoal extends StatelessWidget {
  const HealthGoal({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);
    final stepsTarget = cubit.calculatedStepsTarget ?? 0;
    final caloriesTarget = cubit.calculatedCaloriesTarget ?? 0;
    final caloriesConsumed = 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Text(
            "Health Goal",
            style: AppTextStyles.bold30,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          ...OnboardingConstants.healthGoals.map(
            (goal) => SelectableInfoTile(
              label: goal.goal,
              description: goal.description,
              selectedValue: cubit.healthGoal,
              onSelected: (value) {
                cubit.updateHealthGoal(value);
              },
            ),
          ),
          if (stepsTarget > 0 && caloriesTarget > 0)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SensorDataUploadScreen(),
                  ),
                );
              },
              child: DailyTargetCard(
                stepsTarget: stepsTarget,
                caloriesTarget: caloriesTarget,
                caloriesConsumed: caloriesConsumed,
              ),
            ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
