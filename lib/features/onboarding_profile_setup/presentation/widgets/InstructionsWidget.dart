import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class InstructionsWidget extends StatelessWidget {
  const InstructionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[600]!.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          // Icon(
          //   Icons.info_outline,
          //   color: Colors.grey[400],
          //   size: 24,
          // ),
          // SizedBox(height: 12),
          Text(
            'You can skip this step if you don\'t have a JSON file\n'
            'The file will be processed and imported to your profile\n'
            'You\'ll receive a confirmation once the upload is complete',
            style: TextStyle(color: Colors.grey[400], fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
