import 'package:az_health_care/core/utils/app_images.dart';
import 'package:az_health_care/features/home/presentation/views/profile/widgets/setting_menu_section.dart';
import 'package:az_health_care/features/home/presentation/views/profile/widgets/upgrade_profile_card.dart';

import 'package:flutter/material.dart';

import '../../../../../upgrade/presentation/views/upgrade_plan/upgrade_plan_view.dart';
import 'build_profile_app_bar.dart';
import 'build_user_profile_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BuildProfileAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 15),

                    UpgradeProfileCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpgradePlanView(),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 15),

                    BuildUserProfileCard(
                      onTap: () {
                        print("object");
                      },
                      name: "Mohamed Gomaa",
                      email: 'mohamed.gomaa@gmail.com',
                      image: AppImages.avatarMan,
                    ),

                    SizedBox(height: 15),

                    SettingsMenuSection(),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
