import 'package:az_health_care/features/home/presentation/views/vip/vip_medicine_orders/vip_medicine_orders_view.dart';
import 'package:az_health_care/features/home/presentation/views/vip/widgets/quick_actions_card.dart';
import 'package:flutter/material.dart';

import '../vip_doctor_consultations_view/vip_doctor_consultations_view.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              QuickActionCard(
                icon: Icons.medication,
                title: 'Medicine',
                subtitle: 'Order now',
                color: const Color(0xFF4CAF50),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => VIPMedicineOrdersView(),));

                },
              ),
              const SizedBox(height: 12),
              QuickActionCard(
                icon: Icons.folder_outlined,
                title: 'Records',
                subtitle: 'View history',
                color: const Color(0xFF9C27B0),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              QuickActionCard(
                icon: Icons.video_call,
                title: 'Consultation',
                subtitle: 'Book doctor',
                color: const Color(0xFF2196F3),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VIPDoctorConsultationsView()),
                  );
                },
              ),
              const SizedBox(height: 12),
              QuickActionCard(
                icon: Icons.favorite,
                title: 'Health',
                subtitle: 'Track vitals',
                color: const Color(0xFFFF9800),
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
