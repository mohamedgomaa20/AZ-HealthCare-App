import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/constants.dart';
import '../../shared/components/components.dart';

class ShopSettingsScreen extends StatelessWidget {
  const ShopSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 60,
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: ListTile(
                onTap: () {
                  // navigateTo(context, UpdateProfile());
                },

                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          defaultButton(
            isUpperCase: true,
            text: "Log Out",
            onPressed: () {
              signOut(context);
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
