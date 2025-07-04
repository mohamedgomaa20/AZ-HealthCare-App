import 'package:flutter/material.dart';

import '../../features/onboarding_profile_setup/presentation/views/widgets/gender_view.dart';
import '../utils/app_colors.dart';

class BuildGenderOption extends StatelessWidget {
  const BuildGenderOption({
    super.key,
    required this.context,
    required this.gender,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final BuildContext context;
  final Gender gender;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
