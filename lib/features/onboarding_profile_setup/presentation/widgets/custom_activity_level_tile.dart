import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SelectableInfoTile  extends StatelessWidget {
  final String label;
  final String description;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const SelectableInfoTile ({
    super.key,
    required this.label,
    required this.description,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedValue == label;

    return Column(
      children: [
        Card(
          color: AppColors.blueGrayBackground2,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
            side: BorderSide(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
            onTap: () => onSelected(label),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Radio<String>(
                    value: label,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      if (value != null) onSelected(value);
                    },
                    activeColor: Colors.white,
                    fillColor: WidgetStateProperty.all(
                      isSelected ? AppColors.primaryColor : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: AppTextStyles.bold16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: AppTextStyles.regular14.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// import 'package:az_health_care/core/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:az_health_care/core/utils/app_text_styles.dart';
// import '../../../../../core/utils/app_colors.dart';
// import '../data/models/ActivityLevelOption.dart';
//
// class CustomActivityLevelTile extends StatelessWidget {
//   final ActivityLevelOption activityLevel;
//   final String? selectedLevel;
//   final ValueChanged<String> onSelected;
//
//   const CustomActivityLevelTile({
//     super.key,
//     required this.activityLevel,
//     required this.selectedLevel,
//     required this.onSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = selectedLevel == activityLevel.level;
//
//     return Column(
//       children: [
//         Card(
//           color: AppColors.blueGrayBackground2,
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
//             side: BorderSide(
//               color: isSelected ? AppColors.primaryColor : Colors.transparent,
//               width: 2,
//             ),
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
//             onTap: () => onSelected(activityLevel.level),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Radio<String>(
//                     value: activityLevel.level,
//                     groupValue: selectedLevel,
//                     onChanged: (value) {
//                       if (value != null) {
//                         onSelected(value);
//                       }
//                     },
//                     activeColor: Colors.white,
//                     fillColor: WidgetStateProperty.all(
//                       isSelected ?AppColors.primaryColor : Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           activityLevel.level,
//                           style: AppTextStyles.bold16.copyWith(
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           activityLevel.description,
//                           style: AppTextStyles.regular14.copyWith(
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
