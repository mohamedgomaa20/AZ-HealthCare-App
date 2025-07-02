import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import '../../profile/widgets/build_menu_item.dart';
import 'custom_theme_bottom_sheet.dart';

class AppAppearanceViewBody extends StatelessWidget {
  const AppAppearanceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'App Appearance'),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blueGrayBackground2,
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
              ),
              child: Column(
                children: [
                  BuildMenuItem(
                    title: 'Theme',
                    trailingWidget: Text(
                      "Light",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => CustomThemeBottomSheet(
                          selectedTheme: currentTheme,
                          onThemeChanged: (newTheme) {
                            Navigator.pop(context);
                           },
                        ),
                      );

                    },
                  ),
                  BuildMenuItem(
                    title: 'App Language',
                    trailingWidget: Text(
                      "English",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
