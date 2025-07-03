// import 'package:az_health_care/core/utils/app_text_styles.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../core/utils/app_colors.dart';
// import '../../data/models/payment_method_model.dart';
//
// class PaymentMethodTile extends StatelessWidget {
//   final PaymentMethod paymentMethod;
//
//   const PaymentMethodTile({super.key, required this.paymentMethod});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.blueGrayBackground2,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: paymentMethod.iconColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(
//               paymentMethod.icon,
//               color:
//                   paymentMethod.name == 'Apple Pay'
//                       ? Colors.black
//                       : Colors.white,
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   paymentMethod.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   paymentMethod.subtitle,
//                   style: const TextStyle(color: Colors.white60, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             // decoration: BoxDecoration(
//             //   color:
//             //       paymentMethod.isLinked
//             //           ? AppColors.primaryColor.withOpacity(0.2)
//             //           : Colors.grey.withOpacity(0.2),
//             //   borderRadius: BorderRadius.circular(20),
//             // ),
//             child: Text(
//               paymentMethod.isLinked ? 'Linked' : 'Not Linked',
//               style: AppTextStyles.semiBold14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
