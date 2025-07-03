import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? togglePassword;
  final String? errorText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.togglePassword,
    this.errorText,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bold16.copyWith(color: AppColors.white60Color),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: AppColors.white54Color,

          obscureText: isPassword && !isPasswordVisible,
          inputFormatters: inputFormatters,

          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.regular16.copyWith(
              color: AppColors.white60Color,
            ),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: togglePassword,
                    )
                    : suffixIcon,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          ),
      ],
    );
  }
}
