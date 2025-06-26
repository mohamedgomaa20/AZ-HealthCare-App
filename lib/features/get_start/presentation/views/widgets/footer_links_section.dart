import 'package:flutter/material.dart';
import '../../../../../core/utils/app_text_styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Privacy Policy", style: AppTextStyles.regular14Grey),
        SizedBox(width: 8),
        Text("·", style: AppTextStyles.regular14Grey),
        SizedBox(width: 8),
        Text("Terms of Service", style: AppTextStyles.regular14Grey),
      ],
    );
  }
}
