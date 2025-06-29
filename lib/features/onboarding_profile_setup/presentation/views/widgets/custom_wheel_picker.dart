import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomWheelPicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<String> items;
  final Function(int) onSelectedItemChangedCallback;
  final int currentScrollIndex;
  final double pickerWidth;
  final double? additionalPickerWidth;
  final Widget? additionalWidget;

  const CustomWheelPicker({
    super.key,
    required this.controller,
    required this.items,
    required this.onSelectedItemChangedCallback,
    required this.currentScrollIndex,
    required this.pickerWidth,
    this.additionalPickerWidth,
    this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 70;
    const double pickerTotalHeight = itemHeight * 7;
    final double lineVerticalPosition =
        (pickerTotalHeight / 2) - (itemHeight / 2) - 5;

    return SizedBox(
      width: pickerWidth + 5 + (additionalPickerWidth ?? 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),

              width: pickerWidth + 15,
              height: 2,
              color: AppColors.primaryColor,
            ),
          ),
          Positioned(
            bottom: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: pickerWidth + 15,
              height: 2,
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: pickerTotalHeight,
                width: pickerWidth,
                child: ListWheelScrollView.useDelegate(
                  controller: controller,
                  itemExtent: itemHeight,
                  physics: const FixedExtentScrollPhysics(),
                  perspective: 0.0000001,
                  diameterRatio: 12,
                  onSelectedItemChanged: onSelectedItemChangedCallback,
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: items.length,
                    builder: (context, index) {
                      final item = items[index];
                      final int distance = (index - currentScrollIndex).abs();

                      TextStyle textStyle;

                      if (distance == 0) {
                        textStyle = AppTextStyles.bold50PrimaryColor;
                      } else if (distance == 1) {
                        textStyle = AppTextStyles.regular38White70;
                      } else if (distance == 2) {
                        textStyle = AppTextStyles.regular30White60;
                      } else if (distance == 3) {
                        textStyle = AppTextStyles.regular25White54;
                      } else {
                        textStyle = AppTextStyles.regular20White30;
                      }

                      return Center(child: Text(item, style: textStyle));
                    },
                  ),
                ),
              ),
              if (additionalWidget != null) SizedBox(child: additionalWidget),
            ],
          ),
        ],
      ),
    );
  }
}
