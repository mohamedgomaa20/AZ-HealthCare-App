import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'contact_support_option.dart';

class ContactSupportOptionsList extends StatelessWidget {
  const ContactSupportOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ContactSupportOption(
              icon: Icons.headphones,
              leadingIconColor: AppColors.primaryColor,
              title: 'Customer Support',
              onTap: () {},
            ),
            ContactSupportOption(
              icon: Icons.language,
              leadingIconColor: AppColors.primaryColor,
              title: 'Website',
              onTap: () {},
            ),
            ContactSupportOption(
              icon: LineIcons.whatSApp,
              leadingIconColor: AppColors.primaryColor,
              title: 'WhatsApp',
              onTap: () {},
            ),
            ContactSupportOption(
              icon: Icons.facebook,
              leadingIconColor: AppColors.primaryColor,
              title: 'Facebook',
              onTap: () {},
            ),
            ContactSupportOption(
              icon: LineIcons.twitter,
              leadingIconColor: AppColors.primaryColor,
              title: 'X (Formerly Twitter)',
              onTap: () {},
            ),
            ContactSupportOption(
              icon: LineIcons.instagram,
              leadingIconColor: AppColors.primaryColor,
              title: 'Instagram',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
