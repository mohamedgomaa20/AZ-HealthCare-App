import 'package:flutter/material.dart';

class ValidatedTextField extends StatelessWidget {
  final String? value;
  final Function(String) onValueChange;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? errorMessage;
  final bool isError;
  final Widget? placeholder;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  // final VisualTransformation? visualTransformation;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool filled;
  final int? maxLines;
  final int? minLines;
  final Key? fieldKey;
  final bool expands;
  final bool readOnly;

  const ValidatedTextField({
    super.key,
    required this.value,
    required this.onValueChange,
    this.leadingIcon,
    this.trailingIcon,
    this.errorMessage,
    this.isError = false,
    this.placeholder,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction,
    this.controller,
    // this.visualTransformation,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.style,
    this.hintStyle,
    this.fillColor,
    this.filled = false,
    this.maxLines = 1,
    this.minLines,
    this.fieldKey,
    this.expands = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      controller: controller,
      onChanged: onValueChange,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      readOnly: readOnly,
      style: style ?? const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: leadingIcon,
        suffixIcon: trailingIcon,
        hintText: placeholder != null ? null : '',
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey),
        errorText: isError ? errorMessage : null,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: filled,
        fillColor: fillColor ?? Colors.transparent,
        border: border ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: enabledBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: focusedBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white)),
        errorBorder: errorBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: focusedErrorBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.redAccent)),
      ),
    );
  }
}
