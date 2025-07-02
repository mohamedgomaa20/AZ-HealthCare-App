import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/help_and_support/help_and_support_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_modal_controller.dart';
import '../../app_appearance/app_appearance_view.dart';
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppAppearanceView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpAndSupportView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.star_outline,
            title: 'Rate us',
            onTap: () {},
          ),

          BuildLogoutButton(
            onTap: () async {
              await showCustomModalBottomSheet(
                context: context,
                centerWidget: Text(
                  "Are you sure you want to log out?",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold18.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                title: 'Logout',
                 confirmText: 'Yes, Logout',
                onCancel: () => Navigator.pop(context),
                onConfirm: () {
                  Navigator.pop(context);
                  // Logout logic here
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
