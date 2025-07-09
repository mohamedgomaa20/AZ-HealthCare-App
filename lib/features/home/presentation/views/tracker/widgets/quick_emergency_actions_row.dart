import 'package:az_health_care/features/home/presentation/views/tracker/widgets/quick_emergency_action_button.dart';
import 'package:flutter/material.dart';

class QuickEmergencyActionsRow extends StatelessWidget {
  const QuickEmergencyActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionEmergencyButton(
            icon: Icons.local_hospital,
            title: 'Call Ambulance',
            color: const Color(0xFFE53E3E),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionEmergencyButton(
            icon: Icons.location_on,
            title: 'Send Location',
            color: const Color(0xFF2196F3),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionEmergencyButton(
            icon: Icons.medical_information,
            title: 'Share Medical Info',
            color: const Color(0xFF4CAF50),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
