import 'package:flutter/material.dart';

import '../../../../../../../core/widgets/custom_button.dart';

class PrimaryBottomButton extends StatelessWidget {
  const PrimaryBottomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: CustomButton(text: text, onPressed: onTap),
        ),
      ],
    );
    ;
  }
}
