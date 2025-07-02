import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/app_colors.dart';

class TodayProgressCard extends StatelessWidget {
  const TodayProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.deepBlueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            DateFormat.MMMMEEEEd().format(DateTime.now()),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
