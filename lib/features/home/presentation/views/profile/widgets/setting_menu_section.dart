import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/login_view.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/help_and_support/help_and_support_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/services/cache_helper.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_modal_controller.dart';
import '../../../../../Account/presentation/account_and_security/account_and_security_view.dart';
import '../../../../../Account/presentation/app_appearance/app_appearance_view.dart';
import '../../../../../Account/presentation/billing_and_subscriptions/billing_and_subscriptions_view.dart';
import '../../../../../Account/presentation/data_and_analytics/data_and_analytics_view.dart';
import '../../../../../Account/presentation/linked_accounts/linked_accounts_view.dart';
import '../../../../../Account/presentation/preferences/preferences_view.dart';
import '../../../../../Account/presentation/reminder/reminder_setting_view.dart';
import '../../../../../onboarding_profile_setup/manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../../../../onboarding_profile_setup/manager/sensor_upload_cubit/sensor_upload_cubit.dart';
import '../../../../../payment_methods/presentation/views/payment_methods_view.dart';
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
                  CacheHelper.removeData(key: 'id').then((value) {
                    print(CacheHelper.getData(key: 'id'));
                    context.read<OnboardingProfileSetupCubit>().resetCubit();
                    context.read<SensorUploadCubit>().reset();
                    print(CacheHelper.getData(key: 'id'));

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => GetStartView()),
                      (route) => false,
                    );
                  });

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

void logout(BuildContext context) {
  CacheHelper.removeData(key: "token");
  CacheHelper.removeData(key: "id");

  context.read<OnboardingProfileSetupCubit>().resetCubit();

  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => GetStartView()),
    (Route<dynamic> route) => false,
  );
}
