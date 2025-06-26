import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
    required this.prefixIconData,
    this.suffixIconData,
  });

  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool? isPassword;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validation;
  final IconData prefixIconData;
  final IconData? suffixIconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.whiteColor,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isPassword ?? false,
      onChanged: onChanged,
      validator: validation,
      onSaved: onSaved,

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.buttonColor,
        prefixIcon: Icon(prefixIconData),
        suffixIcon: Icon(suffixIconData),
        hintText: hintText,

        border: buildBorder(),
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
