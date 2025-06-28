import 'package:flutter/material.dart';

class CustomToggleSelector extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final void Function(String) onOptionSelected;
  final double horizontalPadding;
  final double verticalPadding;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final Color? backgroundColor;
  final Color? selectedColor;

  const CustomToggleSelector({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.horizontalPadding = 24,
    this.verticalPadding = 12,
    this.selectedTextStyle,
    this.unselectedTextStyle,
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
        children: options.map((option) {
          final isSelected = option == selectedOption;
          return GestureDetector(
            onTap: () => onOptionSelected(option),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? (selectedColor ?? Theme.of(context).primaryColor)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                option.toUpperCase(),
                style: isSelected
                    ? (selectedTextStyle ??
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ))
                    : (unselectedTextStyle ??
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white70,
                    )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
