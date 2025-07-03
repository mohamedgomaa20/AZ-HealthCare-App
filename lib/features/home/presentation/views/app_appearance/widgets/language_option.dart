import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../data/enums/enums.dart';

class LanguageOption extends StatelessWidget {
  final String label;
  final AppLanguage value;
  final bool selected;
  final VoidCallback onTap;

  const LanguageOption({
    super.key,
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? AppColors.primaryColor : Colors.white54,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white70,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
