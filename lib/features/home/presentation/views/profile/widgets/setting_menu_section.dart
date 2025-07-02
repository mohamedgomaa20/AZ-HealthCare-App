import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';
import 'build_logout_button.dart';
import 'build_menu_item.dart';

class SettingsMenuSection extends StatelessWidget {
  const SettingsMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      ),
      child: Column(
        children: [
          BuildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Preferences',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.access_time_outlined,
            title: 'Reminder',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.security_outlined,
            title: 'Account & Security',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.receipt_outlined,
            title: 'Billing & Subscriptions',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.link_outlined,
            title: 'Linked Accounts',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.analytics_outlined,
            title: 'Data & Analytics',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.palette_outlined,
            title: 'App Appearance',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          BuildMenuItem(
            icon: Icons.star_outline,
            title: 'Rate us',
            onTap: () {},
          ),

          BuildLogoutButton(onTap: () {}),
        ],
      ),
    );
  }
}
