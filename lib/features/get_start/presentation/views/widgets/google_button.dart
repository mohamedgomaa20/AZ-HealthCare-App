import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleButton extends StatefulWidget {
  final String text;
  final String loadingText;
  final VoidCallback? onPressed;

  const GoogleButton({
    super.key,
    this.text = 'Sign Up with Google',
    this.loadingText = 'Creating Account...',
    this.onPressed,
  });

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  bool isLoading = false;

  void _handleTap() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // simulate loading
    setState(() => isLoading = false);
    if (widget.onPressed != null) widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      // borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          // borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.googleIcon, height: 20, width: 20),
            const SizedBox(width: 12),
            Text(
              isLoading ? widget.loadingText : widget.text,
              style: AppTextStyles.semiBold16,
            ),
            if (isLoading)
              Column(
                children: [
                  const SizedBox(width: 20),
                  const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
