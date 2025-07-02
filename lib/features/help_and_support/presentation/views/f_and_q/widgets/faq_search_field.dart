import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FAQSearchField extends StatelessWidget {
  const FAQSearchField({
    super.key,
    required this.controller,
    this.label,
    required this.hint,
    required this.onChanged,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  final String? label;

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(  horizontal:  20),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryColor.withValues(alpha: .5),
        keyboardType: TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          label: label != null ? Text(label!) : null,
          fillColor: AppColors.blueGrayBackground2,
          border: buildOutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          suffixIcon:
              controller.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      controller.clear();
                      onChanged?.call('');
                      FocusScope.of(context).unfocus();
                    },
                  )
                  : null,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          focusedBorder: buildOutlineInputBorder(),
          disabledBorder: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      borderSide: BorderSide.none,
    );
  }
}
