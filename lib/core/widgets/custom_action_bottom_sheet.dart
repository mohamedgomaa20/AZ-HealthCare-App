import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_button.dart';

class CustomActionBottomSheet extends StatelessWidget {
  final String title;
  final String confirmText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final Widget centerWidget;
  final bool? isHasButtons;

  const CustomActionBottomSheet({
    super.key,
    required this.title,
    required this.confirmText,
    required this.onConfirm,
    required this.onCancel,
    required this.centerWidget,
    this.isHasButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),

        border: Border(
          top: BorderSide(color: AppColors.white10Color, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10, thickness: 1),
          const SizedBox(height: 16),
          centerWidget,
          if (isHasButtons != null && !isHasButtons!)
            const Divider(color: Colors.white10, thickness: 1),
          if (isHasButtons != null && isHasButtons!)
            Column(
              children: [
                const SizedBox(height: 16),
                const Divider(color: Colors.white10, thickness: 1),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Cancel",
                        backgroundColor: AppColors.darkGray,
                        onPressed: onCancel,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: confirmText,
                        onPressed: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
