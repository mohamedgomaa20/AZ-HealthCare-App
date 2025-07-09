import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/gender_enum.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';

class GenderView2 extends StatelessWidget {
  const GenderView2({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);
    final selectedGender = cubit.selectedGender;

    Widget _buildGenderOption({
      required Gender gender,
      required String label,
      required IconData icon,
    }) {
      final bool isSelected = selectedGender == gender;

      return GestureDetector(
        onTap: () => cubit.updateGender(gender.label),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? AppColors.primaryColor : AppColors.grayColor,
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                size: 80,
                color: isSelected ? AppColors.whiteColor : Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text("What's your gender?", style: AppTextStyles.bold30),
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGenderOption(
                gender: Gender.male,
                label: 'Male',
                icon: Icons.male,
              ),
              _buildGenderOption(
                gender: Gender.female,
                label: 'Female',
                icon: Icons.female,
              ),
            ],
          ),
          const SizedBox(height: 50),
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedGender == Gender.preferNotToSay
                      ? AppColors.primaryColor
                      : Colors.transparent,
              shape:
                  selectedGender != Gender.preferNotToSay
                      ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColors.grayColor),
                      )
                      : null,
            ),
            onPressed: () => cubit.updateGender('PreferNotToSay'),
            child: Text(
              'Prefer not to say',
              style: AppTextStyles.bold16.copyWith(
                color:
                    selectedGender == Gender.preferNotToSay
                        ? AppColors.whiteColor
                        : AppColors.white70Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
