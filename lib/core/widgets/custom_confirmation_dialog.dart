import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

Future<void> showCustomConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmText,
  required VoidCallback onConfirm,
  String cancelText = 'Cancel',
  Color? backgroundColor,
  Color? titleColor,
  Color? contentColor,
  Color? cancelColor,
  Color? confirmColor,
  double? borderRadius,
}) async {
  await showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? kPrimaryBorderRadius,
            ),
          ),
          backgroundColor: backgroundColor ?? AppColors.blueGrayBackground2,
          title: Text(
            title,
            style: TextStyle(color: titleColor ?? AppColors.whiteColor),
          ),
          content: Text(
            content,
            style: TextStyle(color: contentColor ?? AppColors.white54Color),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                cancelText,
                style: TextStyle(color: cancelColor ?? AppColors.white54Color),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                confirmText,
                style: TextStyle(color: confirmColor ?? AppColors.primaryColor),
              ),
            ),
          ],
        ),
  );
}
