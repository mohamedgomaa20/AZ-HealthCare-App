import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_button.dart';

class WelcomeFooter extends StatelessWidget {
  const WelcomeFooter({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.grey, thickness: 1, height: 32),
        CustomButton(text: "Ok, Let's Start", onPressed: onPressed),
      ],
    );
  }
}
