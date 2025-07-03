import 'package:az_health_care/core/constants.dart';
 import 'package:az_health_care/features/home/presentation/views/account_and_security/widgets/security_switch_tile.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/build_switch_item.dart';
import '../../data_and_analytics/widgets/settings_tile.dart';
import '../../profile/widgets/build_menu_item.dart';

class AccountAndSecurityViewBody extends StatefulWidget {
  const AccountAndSecurityViewBody({super.key});

  @override
  State<AccountAndSecurityViewBody> createState() =>
      _AccountAndSecurityViewBodyState();
}

class _AccountAndSecurityViewBodyState
    extends State<AccountAndSecurityViewBody> {
  bool biometricID = true;
  bool faceID = true;
  bool smsAuth = false;
  bool googleAuth = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Security'),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.blueGrayBackground2,
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
              ),
              child: Column(
                children: [
                  // Switches
                  BuildSwitchItem(
                    title: 'Biometric ID',
                    value: biometricID,
                    onChanged: (v) => setState(() => biometricID = v),
                  ),
                  BuildSwitchItem(
                    title: 'Face ID',
                    value: faceID,
                    onChanged: (v) => setState(() => faceID = v),
                  ),
                  BuildSwitchItem(
                    title: 'SMS Authenticator',
                    value: smsAuth,
                    onChanged: (v) => setState(() => smsAuth = v),
                  ),
                  BuildSwitchItem(
                    title: 'Google Authenticator',
                    value: googleAuth,
                    onChanged: (v) => setState(() => googleAuth = v),
                  ),

                  BuildMenuItem(title: 'Change Password', onTap: () {}),
                  SettingsTile(
                    title: 'Device Management',
                    subtitle:
                        'Manage your account on the various devices you own.',
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  SettingsTile(
                    title: 'Deactivate Account',
                    subtitle:
                        "Temporarily deactivate your account. Easily reactivate when you're ready.",
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),

                  SettingsTile(
                    isDanger: true,
                    title: 'Data Usage',
                    subtitle:
                        'Control how your data is used for analytics. Customize your preferences.',
                    onTap: () {
                      // navigate or show dialog
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
