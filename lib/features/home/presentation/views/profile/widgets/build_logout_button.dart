import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_colors.dart';

class BuildLogoutButton extends StatelessWidget {
  const BuildLogoutButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(Icons.logout, color: AppColors.primaryColor, size: 24),

              SizedBox(width: 16),

              Expanded(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
