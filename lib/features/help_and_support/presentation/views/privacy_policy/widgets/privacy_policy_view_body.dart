import 'package:flutter/material.dart';

import 'package:az_health_care/features/help_and_support/presentation/views/privacy_policy/widgets/section_body.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/privacy_policy/widgets/section_title.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/privacy_policy/widgets/sub_section_title.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';

import 'bullet_item.dart';
import 'effective_date.dart';
import 'intro_text.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Privacy Policy'),
          Expanded(
            child: RawScrollbar(
              thumbColor: AppColors.primaryColor,
              trackColor: AppColors.blueGrayBackground2,
              trackVisibility: true,
              radius: Radius.circular(10),
              thickness: 4,
              thumbVisibility: true,
              padding: EdgeInsets.only(right: 8),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  right: 30,
                  top: 16,
                  bottom: 16,
                  left: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    EffectiveDate(),
                    IntroText(),
                    SectionTitle('1. Information We Collect'),
                    SectionBody(
                      'We collect various types of information to provide you with the best experience possible:',
                    ),

                    SubSectionTitle('1.1 Personal Information'),
                    BulletItem(
                      'Name',
                      'We collect your name to personalize your experience and provide a user-friendly interface.',
                    ),
                    BulletItem(
                      'Email Address',
                      'Your email is used for account creation, login, and communication purposes.',
                    ),
                    BulletItem(
                      'Date of Birth',
                      'This helps us tailor health recommendations according to your age group.',
                    ),
                    BulletItem(
                      'Gender',
                      'Gender information allows us to provide relevant insights based on demographic data.',
                    ),

                    SubSectionTitle('1.2 Health Data'),
                    BulletItem(
                      'Heart Rate',
                      'Collected using device sensors to provide heart health insights and trends.',
                    ),
                    BulletItem(
                      'Blood Pressure',
                      'Used to monitor cardiovascular health and notify you of any abnormalities.',
                    ),
                    BulletItem(
                      'Blood Sugar',
                      'Tracks glucose levels to help users with diabetes or general health monitoring.',
                    ),
                    BulletItem(
                      'Weight',
                      'Used for BMI calculation and overall fitness tracking.',
                    ),
                    BulletItem(
                      'Activity Levels',
                      'Tracks your steps, exercise patterns, and physical movement to give insights into your fitness progress.',
                    ),

                    SubSectionTitle('1.3 Device and Usage Data'),
                    BulletItem(
                      'Device Information',
                      'Includes model, OS, and unique identifiers for troubleshooting and support.',
                    ),
                    BulletItem(
                      'App Usage Data',
                      'Helps us understand which features are most used so we can improve them.',
                    ),
                    BulletItem(
                      'Crash Logs',
                      'Automatically collected in the event of an error or crash to improve app stability.',
                    ),

                    SectionTitle('2. How We Use Your Information'),
                    BulletItem(
                      'To Provide Services',
                      'We use your data to deliver core app functionality like health tracking, reminders, and reports.',
                    ),
                    BulletItem(
                      'To Improve the App',
                      'We analyze usage patterns and feedback to make the app more user-friendly and efficient.',
                    ),
                    BulletItem(
                      'To Send Notifications',
                      'We may send you water reminders, activity alerts, or health check-ins based on your preferences.',
                    ),
                    BulletItem(
                      'To Ensure Safety',
                      'In emergencies, we use your location data to alert your chosen emergency contact.',
                    ),
                    BulletItem(
                      'To Personalize Content',
                      'We customize insights, tips, and recommendations based on your health data and goals.',
                    ),

                    SectionTitle('3. Sharing Your Information'),
                    BulletItem(
                      'With Emergency Contacts',
                      'Your live location can be shared during critical health events.',
                    ),
                    BulletItem(
                      'With Service Providers',
                      'We may share non-personal data with partners for analytics and infrastructure.',
                    ),
                    BulletItem(
                      'Legal Requirements',
                      'We may disclose your information if required by law.',
                    ),
                    BulletItem(
                      'Business Transfers',
                      'In the event of a merger, acquisition, or asset sale, your information may be transferred as part of the transaction.',
                    ),

                    SectionTitle('4. Your Rights'),
                    BulletItem(
                      'Access & Update',
                      'You can access or update your personal data at any time via the app settings.',
                    ),
                    BulletItem(
                      'Delete Account',
                      'You can delete your account and associated data permanently from within the app.',
                    ),
                    BulletItem(
                      'Notification Preferences',
                      'You can customize which types of alerts and notifications you wish to receive.',
                    ),

                    SectionTitle('5. Data Security'),
                    SectionBody(
                      'We implement encryption, access control, and secure storage practices to keep your data safe. While no method is 100% secure, we strive to use commercially acceptable means to protect your data. We regularly audit our systems and train our team on privacy best practices.',
                    ),

                    SectionTitle('6. Changes to This Policy'),
                    SectionBody(
                      'We may update our Privacy Policy from time to time. If we make changes, we will notify you via in-app notifications or email. We recommend reviewing this policy periodically to stay informed about how we are protecting your information.',
                    ),

                    SectionTitle('7. Contact Us'),
                    SectionBody(
                      "If you have any questions about this Privacy Policy or our data practices, please contact us through the app's support section or email us at support@A2ZCARE.app.",
                    ),

                    SizedBox(height: 50),
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
