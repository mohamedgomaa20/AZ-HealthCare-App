import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomToggleSelector extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final void Function(String) onOptionSelected;
  final double horizontalPadding;
  final double verticalPadding;

  final Color? backgroundColor;
  final Color? selectedColor;

  const CustomToggleSelector({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.horizontalPadding = 24,
    this.verticalPadding = 12,

    this.backgroundColor,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            options.map((option) {
              final isSelected = option == selectedOption;
              return GestureDetector(
                onTap: () => onOptionSelected(option),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? (selectedColor ?? AppColors.primaryColor)
                            : AppColors.transparentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    option.toUpperCase(),
                    style:
                        isSelected
                            ? AppTextStyles.bold20
                            : AppTextStyles.bold20.copyWith(
                              color: Colors.white70,
                            ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
