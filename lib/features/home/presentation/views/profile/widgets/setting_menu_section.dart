import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/login_view.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/help_and_support/help_and_support_view.dart';
import 'package:az_health_care/features/home/presentation/views/data_and_analytics/data_and_analytics_view.dart';
import 'package:az_health_care/features/home/presentation/views/linked_accounts/linked_accounts_view.dart';
import 'package:az_health_care/features/home/presentation/views/preferences/preferences_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_modal_controller.dart';
import '../../../../../payment_methods/presentation/views/payment_methods_view.dart';
import '../../account_and_security/account_and_security_view.dart';
import '../../app_appearance/app_appearance_view.dart';
import '../../billing_and_subscriptions/billing_and_subscriptions_view.dart';
import '../../reminder/reminder_setting_view.dart';
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreferencesView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.access_time_outlined,
            title: 'Reminder',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderSettingView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.security_outlined,
            title: 'Account & Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountAndSecurityView(),
                ),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentMethodsView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.receipt_outlined,
            title: 'Billing & Subscriptions',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillingAndSubscriptionsView(),
                ),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.link_outlined,
            title: 'Linked Accounts',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LinkedAccountsView()),
              );
            },
          ),
          BuildMenuItem(
            icon: Icons.analytics_outlined,
            title: 'Data & Analytics',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DataAndAnalyticsView()),
              );
            },
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
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
                isHasButtons: true,
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
