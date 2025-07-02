 import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';

class ContactSupportOption extends StatelessWidget {
  const ContactSupportOption({
    super.key,
    required this.title,
    this.icon,
    this.leadingIconColor,
    this.onTap,
  });

  final String title;

  final IconData? icon;
  final Color? leadingIconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color:
                        leadingIconColor ?? Colors.white.withValues(alpha: 0.8),
                    size: 28,
                  ),
                if (icon != null) SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.6),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
