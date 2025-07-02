import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int current;
  final int goal;
  final Color color;

  const InfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.current,
    required this.goal,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = current / (goal == 0 ? 1 : goal);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$current / $goal',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Spacer(),
              Icon(icon, color: Colors.white, size: 40),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            color: Colors.white,
            backgroundColor: Colors.white24,
            trackGap: 10,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 10),
          Text(
            '${(progress * 100).toStringAsFixed(0)}% Complete',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
