import 'package:az_health_care/features/home/presentation/views/tracker/views/emergency_contact_view.dart';
import 'package:az_health_care/features/home/presentation/views/tracker/views/location_sharing_view.dart';
import 'package:flutter/material.dart';

import '../widgets/tracking_card.dart';

class TrackerView extends StatelessWidget {
  const TrackerView({super.key});

  static const routeName = "trackerView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Tracking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TrackingCard(
                title: 'Location Tracking',
                icon: Icons.map,
                iconColor: Colors.green,
                buttonText: 'Go to Location Sharing',
                buttonIcon: Icons.location_on,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSharingView(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              TrackingCard(
                title: 'Previous Data Tracking',
                icon: Icons.analytics,
                iconColor: Colors.blue,
                buttonText: 'Go to Previous Data Tracking',
                buttonIcon: Icons.history,
                onPressed: () {},
              ),

              const SizedBox(height: 16),

              TrackingCard(
                title: 'Emergency Tracking Settings',
                icon: Icons.emergency,
                iconColor: Colors.red,
                buttonText: 'Go to Emergency Tracking Settings',
                buttonIcon: Icons.local_hospital,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyContactView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
