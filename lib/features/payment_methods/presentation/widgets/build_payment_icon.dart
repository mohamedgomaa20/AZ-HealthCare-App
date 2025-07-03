import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class BuildPaymentIcon extends StatelessWidget {
  const BuildPaymentIcon({
    super.key,
    required this.color,
    required this.label,
    this.textColor,
  });

  final Color color;
  final String label;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? AppColors.whiteColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    ();
  }
}
