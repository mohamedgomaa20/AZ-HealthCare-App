import 'package:az_health_care/features/home/presentation/views/vip/widgets/appointment_card.dart';
import 'package:az_health_care/features/home/presentation/views/vip/widgets/health_summary_row.dart';
import 'package:az_health_care/features/home/presentation/views/vip/widgets/quick_actions_grid.dart';
import 'package:az_health_care/features/home/presentation/views/vip/widgets/vip_member_card.dart';
import 'package:flutter/material.dart';

class VipView extends StatelessWidget {
  const VipView({super.key});

  static const routeName = "vipView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VIP Healthcare',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VIPMemberCard(),

            const SizedBox(height: 20),

            const Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const QuickActionsGrid(),

            const SizedBox(height: 20),

            const Text(
              'Health Summary',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            const HealthSummaryRow(),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Appointments',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const AppointmentCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
