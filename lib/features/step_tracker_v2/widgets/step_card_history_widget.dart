 import 'package:az_health_care/features/step_tracker_v2/widgets/stat_item_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/app_colors.dart';
import '../data/models/step_data.dart';

class StepCardWidget extends StatelessWidget {
  final StepData stepData;

  const StepCardWidget({super.key, required this.stepData});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(stepData.date);
    final isToday =
        DateFormat('yyyy-MM-dd').format(DateTime.now()) == stepData.date;
    final isYesterday =
        DateFormat(
          'yyyy-MM-dd',
        ).format(DateTime.now().subtract(const Duration(days: 1))) ==
        stepData.date;

    String dateLabel;
    if (isToday) {
      dateLabel = 'Today';
    } else if (isYesterday) {
      dateLabel = 'Yesterday';
    } else {
      dateLabel = DateFormat('MMM d, yyyy').format(date);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateLabel,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      DateFormat('EEEE').format(date),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${stepData.steps} steps',
                    style: const TextStyle(
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: StateItemWidget(
                    icon: Icons.local_fire_department,
                    label: 'Calories',
                    value: '${stepData.caloriesBurned}',
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: StateItemWidget(
                    icon: Icons.straighten,
                    label: 'Distance',
                    value: '${stepData.distanceKm.toStringAsFixed(1)} km',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: StateItemWidget(
                    icon: Icons.timer,
                    label: 'Active Min',
                    value: '${stepData.activeMinutes}',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
