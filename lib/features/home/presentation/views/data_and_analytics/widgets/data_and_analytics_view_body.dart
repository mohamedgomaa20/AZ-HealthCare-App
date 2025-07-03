import 'package:az_health_care/features/home/presentation/views/data_and_analytics/widgets/settings_tile.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';

class DataAndAnalyticsViewBody extends StatelessWidget {
  const DataAndAnalyticsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: "Data & Analytics"),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: AppColors.blueGrayBackground2,
              borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SettingsTile(
                  title: 'Data Usage',
                  subtitle:
                      'Control how your data is used for analytics. Customize your preferences.',
                  onTap: () {
                    // navigate or show dialog
                  },
                ),
                SettingsTile(
                  title: 'Ad Preferences',
                  subtitle:
                      'Manage ad personalization settings. Tailor your ad experience.',
                  onTap: () {
                    // handle tap
                  },
                ),
                SettingsTile(
                  title: 'Download My Data',
                  subtitle:
                      'Request a copy of your data. Your information, your control.',
                  onTap: () {
                    // handle tap
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
