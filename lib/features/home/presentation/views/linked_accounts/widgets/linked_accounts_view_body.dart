import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/home/presentation/views/linked_accounts/widgets/social_account_tile.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkedAccountsViewBody extends StatelessWidget {
  const LinkedAccountsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: "Data & Analytics"),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SocialAccountTile(
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: AppColors.googleColor,
                    size: 50,
                  ),
                  platformName: 'Google',
                  isLinked: true,
                  onTap: () {
                    // unlink Google
                  },
                ),
                SocialAccountTile(
                  icon: const FaIcon(
                    FontAwesomeIcons.apple,

                    color: AppColors.whiteColor,
                    size: 50,
                  ),
                  platformName: 'Apple',
                  isLinked: true,
                  onTap: () {
                    // unlink Apple
                  },
                ),
                SocialAccountTile(
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: AppColors.facebookColor,
                    size: 50,
                  ),
                  platformName: 'Facebook',
                  isLinked: false,
                  onTap: () {
                    // link Facebook
                  },
                ),
                SocialAccountTile(
                  icon: const FaIcon(
                    FontAwesomeIcons.twitter,
                    color: AppColors.twitterColor,
                    size: 50,
                  ),
                  platformName: 'Twitter',
                  isLinked: false,
                  onTap: () {
                    // link Twitter
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
