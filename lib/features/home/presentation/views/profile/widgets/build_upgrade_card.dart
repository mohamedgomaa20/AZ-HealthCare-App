// import 'package:az_health_care/core/utils/app_colors.dart';
// import 'package:az_health_care/core/utils/app_images.dart';
// import 'package:az_health_care/core/utils/app_text_styles.dart';
// import 'package:flutter/material.dart';
//
// class BuildUpgradeCard extends StatelessWidget {
//   const BuildUpgradeCard({super.key, required this.onTap});
// final VoidCallback onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.lightYellow, AppColors.deepYellow],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Image.asset(AppImages.proIcon),
//
//
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Upgrade Plan Now!',
//                     style: AppTextStyles.bold18.copyWith(
//                       color: AppColors.redColor,
//                     ),
//                   ),
//
//                   Text(
//                     'Enjoy all the VIP features.',
//                     style: AppTextStyles.regular14.copyWith(
//                       color: AppColors.black87Color,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
