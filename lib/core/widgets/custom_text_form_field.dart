import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.isPassword,
    this.onChanged,
    this.onSaved,
    this.validation,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixOnPressed,
    this.maxLines,
    this.inputFormatters,
  });

  final int? maxLines;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? isPassword;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validation;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final VoidCallback? suffixOnPressed;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      cursorColor: AppColors.whiteColor,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword ?? false,
      inputFormatters: inputFormatters,

      onChanged: onChanged,
      validator: validation,
      onSaved: onSaved,

      decoration: InputDecoration(
        prefixIcon: prefixIconData == null ? null : Icon(prefixIconData),
        suffixIcon: IconButton(
          onPressed: suffixOnPressed,
          icon: Icon(suffixIconData),
        ),
        hintText: hintText,
        hintStyle: AppTextStyles.regular16.copyWith(
          color: AppColors.white60Color,
        ),
        // border: OutlineInputBorder(),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4),
        //   borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        // ),
        // enabledBorder: buildBorder(),
        // disabledBorder: buildBorder(),
        // errorBorder: OutlineInputBorder(),
        // focusedErrorBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    );
  }
}
