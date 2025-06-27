import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/widgets/custom_button.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        // SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: kHorizontalPadding,
          ),
          child: CustomButton(text: "Ok, Let's Start", onPressed: onPressed),
        ),
      ],
    );
  }
}
