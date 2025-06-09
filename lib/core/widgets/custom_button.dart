import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width ?? double.infinity,
          height: height ?? 55,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: buttonColor ?? AppColors.primaryColor,
              foregroundColor: textColor ?? AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize ?? 20,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 0.87,
                letterSpacing: -0.50,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
