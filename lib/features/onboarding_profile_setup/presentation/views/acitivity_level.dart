import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/OnboardingConstants.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
 import '../widgets/custom_activity_level_tile.dart';

class ActivityLevel extends StatelessWidget {
  const ActivityLevel({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 1),
          Text(
            "Activity Level",
            style: AppTextStyles.bold30,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          ...OnboardingConstants.activityLevels.map(
            (level) => SelectableInfoTile(
              label: level.level,
              description: level.description,
              selectedValue: cubit.activityLevel,
              onSelected: (value) {
                cubit.updateActivityLevel(value);
              },
            ),
          ),

          Spacer(flex: 2),
        ],
      ),
    );
  }
}
