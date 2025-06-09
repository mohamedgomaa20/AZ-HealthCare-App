 import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    @required this.keyboardType,
    this.suffixIcon,
    @required this.onSaved,
    this.onChanged,
    @required this.maxLines,
  });

  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final ValueSetter? onSaved;
  final ValueSetter? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffcccccc),
              width: 2,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffcccccc),
              width: 2,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            )),
      ),
    );
  }
}
