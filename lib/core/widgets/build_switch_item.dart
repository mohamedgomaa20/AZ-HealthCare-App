import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class BuildSwitchItem extends StatelessWidget {
  const BuildSwitchItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparentColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,                   style: AppTextStyles.semiBold16.copyWith(color: AppColors.white70Color),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: AppColors.whiteColor,
              inactiveTrackColor: AppColors.white10Color,
            ),
          ],
        ),
      ),
    );
  }
}
