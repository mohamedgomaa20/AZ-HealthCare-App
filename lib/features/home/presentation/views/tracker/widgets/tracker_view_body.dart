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

/*
Center(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  NotificationService.showSimpleNotification(
                    title: '📢 إشعار بسيط',
                    body: 'ده إشعار بسيط لما تدوس على الزرار',
                  );
                },
                child: Text('إشعار بسيط'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  NotificationService.showNetworkImageNotification(
                    imageUrl: 'https://picsum.photos/800/400',
                    title: '📷 إشعار بصورة من الإنترنت',
                    body: 'اضغط علشان تشوف الصورة',
                    summary: 'صورة جميلة من الإنترنت',
                  );
                },
                child: Text('إشعار بصورة من الإنترنت'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  NotificationService.showLocalImageNotification(
                    drawableName: '@mipmap/ic_launcher',
                    title: '🖼️ إشعار بصورة محلية',
                    body: 'دي صورة من داخل التطبيق',
                    summary: 'ده مثال لإشعار بصورة محلية.',
                  );
                },
                child: Text('إشعار بصورة محلية'),
              ),
            ],
          ),
        ),

      )
  http: ^0.13.6
  path_provider: ^2.1.2
  permission_handler: ^11.3.0
  device_info_plus: ^10.1.0
  flutter_local_notifications: ^17.0.0
 */