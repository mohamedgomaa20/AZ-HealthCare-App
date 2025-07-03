import 'package:flutter/material.dart';

import '../../../../../../../core/widgets/custom_button.dart';

class PrimaryBottomButton extends StatelessWidget {
  const PrimaryBottomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.isLeftIcon,
  });

  final String text;
  final IconData? icon;

  final void Function()? onTap;
  final bool? isLeftIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
          child: CustomButton(
            text: text,
            onPressed: onTap,
            icon: icon,
            isLeftIcon: isLeftIcon,
          ),
        ),
      ],
    );
    ;
  }
}
