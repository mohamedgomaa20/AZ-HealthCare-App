import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';
import 'build_toggle_button.dart';

class PlanToggleSwitch extends StatelessWidget {
  const PlanToggleSwitch({super.key, required this.isMonthly,required this.onToggle});

  final bool isMonthly  ;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: BuildToggleButton(
              text: 'Monthly',
              isSelected: isMonthly,
              onTap: () => onToggle(true),
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                BuildToggleButton(
                  text: 'Yearly',
                  isSelected: !isMonthly,
                  onTap: () => onToggle(false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
