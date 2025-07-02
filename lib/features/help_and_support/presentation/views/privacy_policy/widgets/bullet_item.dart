 import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class BulletItem extends StatelessWidget {
  final String title;
  final String description;

  const BulletItem(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              '•',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.semiBold16),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.white70Color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
