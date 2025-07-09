import 'package:flutter/material.dart';
import '../data/models/step_data.dart';
import 'stat_card.dart';

class StepSummaryStats extends StatelessWidget {
  final StepData? todayData;
  final int dailyGoal;

  const StepSummaryStats({
    super.key,
    required this.todayData,
    required this.dailyGoal,
  });

  @override
  Widget build(BuildContext context) {
    final steps = todayData?.steps ?? 0;
    final remainingSteps = (dailyGoal - steps) < 0 ? 0 : (dailyGoal - steps);
    final progressPercent = ((steps / dailyGoal) * 100).clamp(0, 100);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Distance',
                value:
                    '${(todayData?.distanceKm ?? 0.0).toStringAsFixed(2)} km',
                icon: Icons.straighten,
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Calories',
                value: '${todayData?.caloriesBurned ?? 0} cal',
                icon: Icons.local_fire_department,
                color: const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Active Time',
                value: '${todayData?.activeMinutes ?? 0} min',
                icon: Icons.timer,
                color: const Color(0xFFF59E0B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Remaining Steps',
                value: '$remainingSteps steps',
                icon: Icons.schedule,
                color: const Color(0xFFEF4444),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Progress',
                value: '${progressPercent.toInt()}%',
                icon: Icons.trending_up,
                color: const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
