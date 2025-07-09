import 'package:flutter/material.dart';

import '../widgets/emergency_call_card.dart';
import '../widgets/emergency_services_contact.dart';
import '../widgets/quick_emergency_actions_row.dart';

class EmergencyContactView extends StatelessWidget {
  const EmergencyContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53E3E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Emergency Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const EmergencyCallCard(),
            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const QuickEmergencyActionsRow(),
            const SizedBox(height: 24),
            const Text(
              'Emergency Contacts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            EmergencyServicesContact(
              name: 'John Doe',
              relation: 'Father',
              phone: '+1 555 123 4567',
            ),
            const SizedBox(height: 12),
            EmergencyServicesContact(
              name: 'Jane Smith',
              relation: 'Sister',
              phone: '+1 555 987 6543',
            ),
            const SizedBox(height: 12),
            EmergencyServicesContact(
              name: 'Dr. Hassan',
              relation: 'Family Doctor',
              phone: '+1 555 456 7890',
            ),
          ],
        ),
      ),
    );
  }
}
