import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils/app_colors.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    super.key,
    this.backgroundColor,
    this.loadingColor,
    this.height,
    this.width,
  });

  final Color? backgroundColor;
  final Color? loadingColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 45,
      child: TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor:
              backgroundColor ?? AppColors.primaryColor.withValues(alpha: 0.3),
          foregroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
        ),
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: loadingColor ?? Colors.white),
        ),
      ),
    );
  }
}
