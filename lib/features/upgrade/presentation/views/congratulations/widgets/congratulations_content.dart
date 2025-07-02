import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:flutter/material.dart';
 import 'package:az_health_care/core/utils/app_text_styles.dart';

import '../../../../../home/presentation/views/profile/widgets/primary_bottom_button.dart';
import '../../review_summary/widgets/features_summary_list.dart';

class CongratulationsContent extends StatelessWidget {
  const CongratulationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFF59E0B), Color(0xFFEAB308)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'You\'ve Unlocked One Year Pro Subscriptions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                Text('Benefits Unlocked:', style: AppTextStyles.bold20),
                const SizedBox(height: 20),
                const FeaturesSummaryList(),
                const Divider(),
                const Spacer(),
                const SizedBox(height: 20),
                Text(
                  'Your subscription will automatically renew annually unless cancelled. Manage your subscription in settings.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular14,
                ),
              ],
            ),
          ),
        ),
        PrimaryBottomButton(
          text: "Start Exploring Premium Features",
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeLayout.routeName,
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
