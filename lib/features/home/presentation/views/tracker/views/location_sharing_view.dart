import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
 import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../onboarding_profile_setup/data/models/EmergencyContactsResponse.dart';

class LocationSharingView extends StatelessWidget {
  const LocationSharingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Sharing", style: AppTextStyles.bold20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.blueGrayBackground2,
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      Text("Your Current Location"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                      SizedBox(width: 10),
                      Text("getting Location ..."),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text("Share with:"),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder:
                    (context, index) => ItemCard(
                      emergencyContactModel: contactList[index],
                      onPressed: null,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.emergencyContactModel,
    required this.onPressed,
  });

  final EmergencyContactModel emergencyContactModel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        color: AppColors.blueGrayBackground2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              CircleAvatar(child: Icon(Icons.person)),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(emergencyContactModel.name ?? "user"),
                  SizedBox(height: 5),
                  Text(
                    emergencyContactModel.email ?? "2@2.com",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: 90,
                height: 45,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send, color: Colors.white),
                      SizedBox(width: 5),
                      Text("share"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<EmergencyContactModel> contactList = [
  EmergencyContactModel(
    name: "mohamed reda",
    contactId: 1,
    email: "20m@gmail.com",
    phoneNumber: "01211525577",
  ),

  EmergencyContactModel(
    name: "mohamed mahmoud",
    contactId: 1,
    email: "mah45@gmail.com",
    phoneNumber: "522548888484",
  ),

  EmergencyContactModel(
    name: "ahmed reda",
    contactId: 1,
    email: "ahmed@gmail.com",
    phoneNumber: "18848482488",
  ),

  EmergencyContactModel(
    name: "mohamed ali",
    contactId: 1,
    email: "mali2@gmail.com",
    phoneNumber: "01211525577",
  ),

  EmergencyContactModel(
    name: "ali hasan",
    contactId: 1,
    email: "alim@gmail.com",
    phoneNumber: "18845548884",
  ),

  EmergencyContactModel(
    name: "mohamed reda",
    contactId: 1,
    email: "20m@gmail.com",
    phoneNumber: "01211525577",
  ),

  EmergencyContactModel(
    name: "mohamed osama",
    contactId: 1,
    email: "osama@gmail.com",
    phoneNumber: "01211525577",
  ),
];
