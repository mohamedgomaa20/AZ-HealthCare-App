import 'package:flutter/material.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';


class BottomSheetOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomSheetOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
            border: isSelected ? Border.all(color: AppColors.primaryColor) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primaryColor : Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isSelected)
                const Icon(Icons.check, color: AppColors.primaryColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
