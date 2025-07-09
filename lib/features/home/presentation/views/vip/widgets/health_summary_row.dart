import 'package:flutter/material.dart';

import '../vip_view.dart';
import 'health_summary_card.dart';

class HealthSummaryRow extends StatelessWidget {
  const HealthSummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,

      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Expanded(
            child: HealthSummaryCard(
              icon: Icons.favorite,
              value: '120/80',
              unit: 'mmHg',
              color: const Color(0xFFE53E3E),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: HealthSummaryCard(
              icon: Icons.favorite,
              value: '72',
              unit: 'bpm',
              color: const Color(0xFFE91E63),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: HealthSummaryCard(
              icon: Icons.show_chart,
              value: '70',
              unit: 'kg',
              color: const Color(0xFF9C27B0),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: HealthSummaryCard(
              icon: Icons.show_chart,
              value: '70',
              unit: 'kg',
              color: const Color(0xFF9C27B0),
            ),
          ),
        ],
      ),
    );
  }
}
