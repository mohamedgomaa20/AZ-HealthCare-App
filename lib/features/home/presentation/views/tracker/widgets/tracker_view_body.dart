import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/features/home/presentation/views/tracker/views/EmergencyContactsView.dart';
import 'package:az_health_care/features/home/presentation/views/tracker/views/location_sharing_view.dart';
import 'package:flutter/material.dart';

class TrackerViewBody extends StatelessWidget {
  const TrackerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BuildAppBar(title: "Tracker"),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomButton(
                  text: "Go To Location Sharing",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationSharingView(),
                        // builder: (context) => EmergencyContactsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
