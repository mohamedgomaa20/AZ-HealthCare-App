import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/Auth/presentation/views/welcome_to_a2z_care/widgets/welcome_footer.dart';
import 'package:az_health_care/features/Auth/presentation/views/welcome_to_a2z_care/widgets/welcome_header.dart';
import 'package:flutter/material.dart';

import '../../../../../personal_info/presentation/views/personal_info_view.dart';

class WelcomeToA2zCareViewBody extends StatelessWidget {
  const WelcomeToA2zCareViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: kHorizontalPadding,
          ),
          child: const WelcomeHeader(),
        ),
        WelcomeFooter(
          onPressed: () {
            Navigator.pushNamed(context, PersonalInfoView.routeName);
          },
        ),
      ],
    );
  }
}
