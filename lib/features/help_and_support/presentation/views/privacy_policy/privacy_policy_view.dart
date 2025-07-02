import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
 

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: PrivacyPolicyContent());
  }
}


class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Privacy Policy'),
          Expanded(
            child: RawScrollbar(
              thumbColor: AppColors.primaryColor,
              trackColor: AppColors.grayDarkColor.withValues(alpha: .2),
              trackVisibility: true,
              radius: Radius.circular(10),
              thickness: 4,
              thumbVisibility: true,
              padding: EdgeInsets.only(right: 8),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 35,
                  top: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _EffectiveDate(),
                    _IntroText(),
                    _SectionTitle('1. Information We Collect'),
                    _SectionBody(
                      'We collect various types of information to provide you with the best experience possible:',
                    ),

                    _SubSectionTitle('1.1 Personal Information'),
                    _BulletItem(
                      'Name',
                      'We collect your name to personalize your experience and provide a user-friendly interface.',
                    ),
                    _BulletItem(
                      'Email Address',
                      'Your email is used for account creation, login, and communication purposes.',
                    ),
                    _BulletItem(
                      'Date of Birth',
                      'This helps us tailor health recommendations according to your age group.',
                    ),
                    _BulletItem(
                      'Gender',
                      'Gender information allows us to provide relevant insights based on demographic data.',
                    ),

                    _SubSectionTitle('1.2 Health Data'),
                    _BulletItem(
                      'Heart Rate',
                      'Collected using device sensors to provide heart health insights and trends.',
                    ),
                    _BulletItem(
                      'Blood Pressure',
                      'Used to monitor cardiovascular health and notify you of any abnormalities.',
                    ),
                    _BulletItem(
                      'Blood Sugar',
                      'Tracks glucose levels to help users with diabetes or general health monitoring.',
                    ),
                    _BulletItem(
                      'Weight',
                      'Used for BMI calculation and overall fitness tracking.',
                    ),
                    _BulletItem(
                      'Activity Levels',
                      'Tracks your steps, exercise patterns, and physical movement to give insights into your fitness progress.',
                    ),

                    _SubSectionTitle('1.3 Device and Usage Data'),
                    _BulletItem(
                      'Device Information',
                      'Includes model, OS, and unique identifiers for troubleshooting and support.',
                    ),
                    _BulletItem(
                      'App Usage Data',
                      'Helps us understand which features are most used so we can improve them.',
                    ),
                    _BulletItem(
                      'Crash Logs',
                      'Automatically collected in the event of an error or crash to improve app stability.',
                    ),

                    _SectionTitle('2. How We Use Your Information'),
                    _BulletItem(
                      'To Provide Services',
                      'We use your data to deliver core app functionality like health tracking, reminders, and reports.',
                    ),
                    _BulletItem(
                      'To Improve the App',
                      'We analyze usage patterns and feedback to make the app more user-friendly and efficient.',
                    ),
                    _BulletItem(
                      'To Send Notifications',
                      'We may send you water reminders, activity alerts, or health check-ins based on your preferences.',
                    ),
                    _BulletItem(
                      'To Ensure Safety',
                      'In emergencies, we use your location data to alert your chosen emergency contact.',
                    ),
                    _BulletItem(
                      'To Personalize Content',
                      'We customize insights, tips, and recommendations based on your health data and goals.',
                    ),

                    _SectionTitle('3. Sharing Your Information'),
                    _BulletItem(
                      'With Emergency Contacts',
                      'Your live location can be shared during critical health events.',
                    ),
                    _BulletItem(
                      'With Service Providers',
                      'We may share non-personal data with partners for analytics and infrastructure.',
                    ),
                    _BulletItem(
                      'Legal Requirements',
                      'We may disclose your information if required by law.',
                    ),
                    _BulletItem(
                      'Business Transfers',
                      'In the event of a merger, acquisition, or asset sale, your information may be transferred as part of the transaction.',
                    ),

                    _SectionTitle('4. Your Rights'),
                    _BulletItem(
                      'Access & Update',
                      'You can access or update your personal data at any time via the app settings.',
                    ),
                    _BulletItem(
                      'Delete Account',
                      'You can delete your account and associated data permanently from within the app.',
                    ),
                    _BulletItem(
                      'Notification Preferences',
                      'You can customize which types of alerts and notifications you wish to receive.',
                    ),

                    _SectionTitle('5. Data Security'),
                    _SectionBody(
                      'We implement encryption, access control, and secure storage practices to keep your data safe. While no method is 100% secure, we strive to use commercially acceptable means to protect your data. We regularly audit our systems and train our team on privacy best practices.',
                    ),

                    _SectionTitle('6. Changes to This Policy'),
                    _SectionBody(
                      'We may update our Privacy Policy from time to time. If we make changes, we will notify you via in-app notifications or email. We recommend reviewing this policy periodically to stay informed about how we are protecting your information.',
                    ),

                    _SectionTitle('7. Contact Us'),
                    _SectionBody(
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

class _CustomAppBar extends StatelessWidget {
  final String title;

  const _CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EffectiveDate extends StatelessWidget {
  const _EffectiveDate();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        'Effective Date: ${DateFormat('MMMM d yyyy').format(DateTime.now())}',
        style: AppTextStyles.bold24.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to A2Z Care, the health and wellness app designed to help you monitor your heart rate, blood pressure, blood sugar, weight, and more. Your privacy is important to us, and this Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application, A2Z Care (the "App").',
      style: AppTextStyles.semiBold16.copyWith(color: AppColors.white70Color),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.bold20.copyWith(color: AppColors.whiteColor),
      ),
    );
  }
}

class _SubSectionTitle extends StatelessWidget {
  final String text;

  const _SubSectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Text(text, style: AppTextStyles.semiBold16),
    );
  }
}

class _SectionBody extends StatelessWidget {
  final String text;

  const _SectionBody(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.semiBold16.copyWith(color: AppColors.white70Color),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String title;
  final String description;

  const _BulletItem(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              '•',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.semiBold16),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.white70Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
