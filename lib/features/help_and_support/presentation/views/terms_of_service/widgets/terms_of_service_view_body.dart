import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import '../../privacy_policy/widgets/bullet_item.dart';
import '../../privacy_policy/widgets/effective_date.dart';

import '../../privacy_policy/widgets/section_body.dart';
import '../../privacy_policy/widgets/section_title.dart';

class TermsOfServiceBody extends StatelessWidget {
  const TermsOfServiceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Terms of Service'),
          Expanded(
            child: RawScrollbar(
              thumbColor: AppColors.primaryColor,
              trackColor: AppColors.blueGrayBackground2,
              trackVisibility: true,
              radius: Radius.circular(10),
              thickness: 4,
              thumbVisibility: true,
              padding: const EdgeInsets.only(right: 8),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  right: 30,
                  top: 16,
                  bottom: 16,
                  left: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    EffectiveDate(),
                    SectionTitle('1. Acceptance of Terms'),
                    SectionBody(
                      'By accessing and using the A2Z Care app, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree, please do not use the app.',
                    ),

                    SectionTitle('2. Use of the App'),
                    BulletItem(
                      'Eligibility',
                      'You must be at least 13 years old to use this app. If you are under 18, you must have parental consent.',
                    ),
                    BulletItem(
                      'Account Security',
                      'You are responsible for maintaining the confidentiality of your account credentials and activities that occur under your account.',
                    ),
                    BulletItem(
                      'Prohibited Activities',
                      'You agree not to misuse the app, such as attempting unauthorized access, disrupting the service, or violating laws.',
                    ),

                    SectionTitle('3. Intellectual Property'),
                    SectionBody(
                      'All content, logos, and trademarks in the app are the property of A2Z Care and protected by copyright laws. You may not use, copy, or distribute any content without written permission.',
                    ),

                    SectionTitle('4. Health Disclaimer'),
                    SectionBody(
                      'A2Z Care does not provide medical advice. All features are intended for informational purposes only and should not replace professional medical consultation.',
                    ),

                    SectionTitle('5. Termination'),
                    SectionBody(
                      'We reserve the right to suspend or terminate your access to the app at any time, without notice, for conduct that we believe violates these Terms or is harmful to other users.',
                    ),

                    SectionTitle('6. Changes to Terms'),
                    SectionBody(
                      'We may update these Terms from time to time. Continued use of the app after changes means you accept the updated terms.',
                    ),

                    SectionTitle('7. Contact Us'),
                    SectionBody(
                      'For any questions about these Terms, please contact us via the app support or at support@A2ZCARE.app.',
                    ),

                    SectionTitle('8. User-Generated Content'),
                    SectionBody(
                      'You are solely responsible for any content you submit through the app. You agree not to upload any content that is unlawful, offensive, or violates third-party rights.',
                    ),

                    SectionTitle('9. Third-Party Services'),
                    SectionBody(
                      'Our app may contain links or integrations with third-party services. We are not responsible for their content, privacy practices, or services. Use of such services is at your own risk.',
                    ),

                    SectionTitle('10. Data Collection and Usage'),
                    SectionBody(
                      'By using the app, you consent to the collection and use of information as described in our Privacy Policy.',
                    ),

                    SectionTitle('11. Limitation of Liability'),
                    SectionBody(
                      'To the maximum extent permitted by law, A2Z Care shall not be liable for any indirect, incidental, or consequential damages arising out of or related to your use of the app.',
                    ),

                    SectionTitle('12. Governing Law'),
                    SectionBody(
                      'These Terms shall be governed by and construed in accordance with the laws of your country of residence, without regard to conflict of law principles.',
                    ),

                    SectionTitle('13. Entire Agreement'),
                    SectionBody(
                      'These Terms constitute the entire agreement between you and A2Z Care regarding your use of the app and supersede all prior agreements.',
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
