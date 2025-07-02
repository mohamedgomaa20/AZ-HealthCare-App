import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Welcome 👋',
          style: AppTextStyles.bold26,
        ),
      ),
    );
  }
}
