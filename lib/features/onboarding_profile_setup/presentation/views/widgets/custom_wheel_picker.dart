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
    this.additionalPickerWidth, this.additionalWidget,
  });

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 70;
    const double pickerTotalHeight = itemHeight * 7;
    final double lineVerticalPosition =
        (pickerTotalHeight / 2) - (itemHeight / 2) - 5;

    return SizedBox(
      width: pickerWidth + 5+ (additionalPickerWidth ?? 0),
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
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
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
                      double fontSize;
                      Color textColor;

                      if (distance == 0) {
                        fontSize = 50;
                        textColor = Theme.of(context).primaryColor;
                      } else if (distance == 1) {
                        fontSize = 38;
                        textColor = Colors.white70;
                      } else if (distance == 2) {
                        fontSize = 30;
                        textColor = Colors.white60;
                      } else if (distance == 3) {
                        fontSize = 25;
                        textColor = Colors.white54;
                      } else {
                        fontSize = 20;
                        textColor = Colors.white30;
                      }

                      return Center(
                        child: Text(
                          item,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(
                            color: textColor,
                            fontSize: fontSize,
                            fontWeight:
                                distance == 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (additionalWidget != null)
                SizedBox(

                  child: additionalWidget,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
