import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../features/home/presentation/views/reminder/widget/bottom_sheet_option.dart';
import 'custom_button.dart';

class CustomPickerBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final String initialValue;
  final Function(String) onConfirm;

  const CustomPickerBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.initialValue,
    required this.onConfirm,
  });

  @override
  State<CustomPickerBottomSheet> createState() =>
      _CustomPickerBottomSheetState();
}

class _CustomPickerBottomSheetState extends State<CustomPickerBottomSheet> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

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
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: AppTextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.grayColor.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              final isSelected = selectedValue == item;
              return BottomSheetOption(
                title: item,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    selectedValue = item;
                  });
                },
              );
            },
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.grayColor.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Cancel",
                  backgroundColor: AppColors.darkGray,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  text: "Confirm",
                  onPressed: () {
                    widget.onConfirm(selectedValue);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
