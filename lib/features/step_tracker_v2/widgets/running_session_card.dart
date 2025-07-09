import 'package:az_health_care/features/step_tracker_v2/widgets/stat_item_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_colors.dart';
import '../data/models/running_session.dart';

class RunningSessionCard extends StatelessWidget {
  final RunningSession session;
  final VoidCallback? onTap;

  const RunningSessionCard({super.key, required this.session, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = session.isActive;
    final duration = session.duration;
    final formattedDuration =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          border: isActive ? Border.all(color: Colors.green, width: 2) : null,
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
                        DateFormat('MMM d, yyyy').format(session.startTime),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Text(
                        DateFormat('h:mm a').format(session.startTime),
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
                      color:
                          isActive
                              ? Colors.green.withOpacity(0.1)
                              : const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isActive ? 'Active' : 'Completed',
                      style: TextStyle(
                        color:
                            isActive ? Colors.green : const Color(0xFF6366F1),
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
                      icon: Icons.timer,
                      label: 'Duration',
                      value: formattedDuration,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: StateItemWidget(
                      icon: Icons.directions_walk,
                      label: 'Steps',
                      value: '${session.steps}',
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: StateItemWidget(
                      icon: Icons.straighten,
                      label: 'Distance',
                      value: '${session.distance.toStringAsFixed(2)} km',
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: StateItemWidget(
                      icon: Icons.local_fire_department,
                      label: 'Calories',
                      value: session.caloriesBurned.toStringAsFixed(0),
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
