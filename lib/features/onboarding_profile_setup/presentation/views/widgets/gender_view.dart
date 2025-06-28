import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

enum Gender { male, female, preferNotToSay }

class GenderView extends StatelessWidget {
  final Gender? selectedGender;
  final Function(Gender) onGenderSelected;

  const GenderView({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  Widget _buildGenderOption({
    required BuildContext context,
    required Gender gender,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () => onGenderSelected(gender),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : AppColors.grayColor,
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What's your gender?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGenderOption(
                context: context,
                gender: Gender.male,
                label: 'Male',
                icon: Icons.male,
              ),
              _buildGenderOption(
                context: context,
                gender: Gender.female,
                label: 'Female',
                icon: Icons.female,
              ),
            ],
          ),
          const SizedBox(height: 50),
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedGender == Gender.preferNotToSay
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              shape: selectedGender != Gender.preferNotToSay
                  ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.grayColor),
              )
                  : null,
            ),
            onPressed: () => onGenderSelected(Gender.preferNotToSay),
            child: Text(
              'Prefer not to say',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: selectedGender == Gender.preferNotToSay
                    ? AppColors.whiteColor
                    : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
