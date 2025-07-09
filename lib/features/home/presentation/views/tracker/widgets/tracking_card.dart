import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'custom_tracker_card.dart';

class TrackingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const TrackingCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      ),
      child: Column(
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 40),
          ),

          const SizedBox(height: 24),

          CustomTrackerButton(
            text: buttonText,
            icon: buttonIcon,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
