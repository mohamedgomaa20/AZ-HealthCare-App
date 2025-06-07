import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.buttonColor = const Color(0xff0000ff),
    this.textColor = Colors.white,
    this.fontSize = 23,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isEnabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: buttonColor,

              padding: EdgeInsets.symmetric(
                vertical: fontSize! < 22 ? 18.0 : 16,
                horizontal: 32.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
