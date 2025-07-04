import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/water_tracking_cubit.dart';
import '../../models/interval_model.dart';

class WaterReminderSection extends StatelessWidget {
  final List<IntervalModel> intervals;

  const WaterReminderSection({Key? key, required this.intervals})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reminder Intervals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                intervals
                    .map((interval) => _buildIntervalChip(context, interval))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntervalChip(BuildContext context, IntervalModel interval) {
    return GestureDetector(
      onTap:
          () => context.read<WaterTrackingCubit>().selectInterval(
            interval.minute,
          ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              interval.selected ? const Color(0xFF00D4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                interval.selected
                    ? const Color(0xFF00D4FF)
                    : Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          interval.displayName ?? '${interval.minute}m',
          style: TextStyle(
            color: interval.selected ? Colors.black : Colors.white,
            fontWeight: interval.selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
