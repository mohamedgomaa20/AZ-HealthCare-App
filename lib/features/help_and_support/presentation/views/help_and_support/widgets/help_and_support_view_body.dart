import 'package:az_health_care/features/help_and_support/presentation/views/f_and_q/f_and_q_view.dart';
import 'package:az_health_care/features/help_and_support/presentation/views/terms_of_service/terms_of_service_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../home/presentation/views/profile/widgets/build_menu_item.dart';
import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import '../../contact_support/contact_support_view.dart';
import '../../privacy_policy/privacy_policy_view.dart';

class HelpAndSupportViewBody extends StatelessWidget {
  const HelpAndSupportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Help & Support'),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrayBackground2,
                        borderRadius: BorderRadius.circular(
                          kPrimaryBorderRadius,
                        ),
                      ),

                      child: Column(
                        children: [
                          BuildMenuItem(
                            title: 'FAQ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FAndQView(),
                                ),
                              );
                            },
                          ),
                          BuildMenuItem(
                            title: 'Contact Support',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ContactSupportView(),
                                ),
                              );
                            },
                          ),
                          BuildMenuItem(title: 'Privacy Policy', onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicyView()));

                          }),
                          BuildMenuItem(
                            title: 'Terms of Service',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const TermsOfServiceView(

                                      )));


                            },
                          ),
                          BuildMenuItem(title: 'Partner', onTap: () {}),
                          BuildMenuItem(title: 'Job Vacancy', onTap: () {}),
                          BuildMenuItem(title: 'Accessibility', onTap: () {}),
                          BuildMenuItem(title: 'Feedback', onTap: () {}),
                          BuildMenuItem(title: 'About us', onTap: () {}),
                          BuildMenuItem(title: 'Rate us', onTap: () {}),
                          BuildMenuItem(
                            title: 'Visit Our Website',
                            onTap: () {},
                          ),
                          BuildMenuItem(
                            title: 'Follow us on Social Media',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
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
