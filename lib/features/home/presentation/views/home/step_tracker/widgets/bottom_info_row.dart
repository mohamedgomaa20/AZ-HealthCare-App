import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/stat_tile.dart';
import 'package:flutter/material.dart';

class BottomInfoRow extends StatelessWidget {
  const BottomInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: StatTile(label: 'Active Min', value: '0', icon: Icons.timer),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatTile(
            label: 'Distance',
            value: 'km 0.00',
            icon: Icons.show_chart,
          ),
        ),
      ],
    );
  }
}
