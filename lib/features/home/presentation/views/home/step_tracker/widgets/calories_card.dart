import 'package:flutter/material.dart';

 import 'info_card.dart';

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      icon: Icons.local_fire_department,
      label: 'Calories Burned',
      current: 0,
      goal: 74,
      color: const Color(0xFF783857),
    );
  }
}
