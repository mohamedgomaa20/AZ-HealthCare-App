import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';

class BuildUserProfileCard extends StatelessWidget {
  const BuildUserProfileCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.email,
    // required this.image,
  });

  final String name;
  final String email;

  final VoidCallback onTap;
  // final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(name.substring(0, 2), style: TextStyle(fontSize: 30)),
          ),
          SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 20),

          OutlinedButton(
            onPressed:onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Edit Profile"),
                SizedBox(width: 10),
                Icon(Icons.edit),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     // Profile Image
          //     Container(
          //       width: 50,
          //       height: 50,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //           image: AssetImage(image),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //
          //     SizedBox(width: 15),
          //
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             name,
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           SizedBox(height: 4),
          //           Text(
          //             email,
          //             style: TextStyle(
          //               color: Colors.white.withValues(alpha: 0.7),
          //               fontSize: 14,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //
          //     Icon(
          //       Icons.chevron_right,
          //       color: Colors.white.withValues(alpha: 0.7),
          //       size: 24,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
    ;
  }
}
