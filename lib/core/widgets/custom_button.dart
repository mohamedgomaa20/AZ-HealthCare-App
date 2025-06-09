 import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonText});
    final String buttonText;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 345,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          decoration: ShapeDecoration(
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 0.87,
                  letterSpacing: -0.50,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
