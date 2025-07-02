import 'package:flutter/material.dart';

import '../step_tracker_view.dart';
import 'info_card.dart';

class StepsCard extends StatelessWidget {
  const StepsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      icon: Icons.directions_walk,
      label: 'Steps',
      current: 0,
      goal: 11000,
      color: const Color(0xFF4B5563),
    );
  }
}
