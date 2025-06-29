import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../utils/app_text_styles.dart';

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    this.label,
    super.key,
    required this.hintText,
    required this.controller,
    required this.isPassword,
    this.prefixIcon,
    required this.suffixIcon,
    required this.onChanged,
    required this.onToggleVisibility,
    this.isValidatePassword = true,
    this.newPasswordController,
  });

  final bool isValidatePassword;
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData suffixIcon;
  final void Function(String) onChanged;
  final VoidCallback onToggleVisibility;
  final TextEditingController? newPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? "Password", style: AppTextStyles.semiBold16),
        const SizedBox(height: 5),

        CustomTextFormField(
          hintText: hintText,
          keyboardType: TextInputType.visiblePassword,
          controller: controller,
          prefixIconData: prefixIcon ?? Icons.lock,
          validation: isValidatePassword ? _validatePassword : null,
          suffixIconData: suffixIcon,
          suffixOnPressed: onToggleVisibility,
          isPassword: isPassword,
          onChanged: onChanged,
        ),
      ],
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (newPasswordController == null){
    if (value.length < 8) return 'Password must be at least 8 characters';
      final hasUppercase = value.contains(RegExp(r'[A-Z]'));
      final hasLowercase = value.contains(RegExp(r'[a-z]'));
      final hasDigit = value.contains(RegExp(r'[0-9]'));
      final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      if (!hasUppercase) return 'Password must include an uppercase letter';
      if (!hasLowercase) return 'Password must include a lowercase letter';
      if (!hasDigit) return 'Password must include a number';
      if (!hasSpecialChar) return 'Password must include a special character';
    }
    if (newPasswordController != null &&
        controller.text != newPasswordController!.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
