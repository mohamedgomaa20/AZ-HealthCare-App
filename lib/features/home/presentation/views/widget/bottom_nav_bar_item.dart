import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.iconData,
    required this.label,
  });

  final IconData iconData;

  final String label;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(iconData),
      label: label,
      selectedIcon: Icon(iconData, color: AppColors.primaryColor),
    );
  }
}
