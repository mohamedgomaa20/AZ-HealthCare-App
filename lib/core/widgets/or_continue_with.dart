import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class OrContinueWith extends StatelessWidget {
  const OrContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.grayColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or continue with",
            style: TextStyle(color: AppColors.whiteColor, fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color: AppColors.grayColor)),
      ],
    );
  }
}
