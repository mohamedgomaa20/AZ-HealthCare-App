// import 'package:az_health_care/core/utils/app_colors.dart';
// import 'package:az_health_care/core/utils/app_text_styles.dart';
// import 'package:flutter/material.dart';
//
// class GuestUserCard extends StatelessWidget {
//   const GuestUserCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){},
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 20, left: 20,bottom: 16,right: 5),
//         margin: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: AppColors.backgroundStepColor,
//           // color: Color(0xFF2A2A2A),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: AppColors.blackColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.person, color: AppColors.whiteColor, size: 50),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Guest User', style: AppTextStyles.semiBold18),
//                   Text(
//                     'Tap to load details',
//                     style: AppTextStyles.regular14.copyWith(
//                       color: AppColors.grayColor.withValues(alpha: 0.8),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.arrow_forward_ios,
//                 color: AppColors.grayColor,
//                 size: 25,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     ;
//   }
// }
