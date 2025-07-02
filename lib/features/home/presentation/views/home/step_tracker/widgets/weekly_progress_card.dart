import 'package:flutter/material.dart';

class WeeklyProgressCard extends StatelessWidget {
  const WeeklyProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Weekly Progress\n\nNo data available yet',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}
