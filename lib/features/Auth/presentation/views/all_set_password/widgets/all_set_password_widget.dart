import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AllSetPasswordWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOkGreatPressed;

  const AllSetPasswordWidget({
    super.key,
    this.title = "You're All Set!",
    this.message = "Your password has been updated.",
    required this.onOkGreatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const Spacer(flex: 3),
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.phone_android,
                    size: 85,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Icon(
                      Icons.person,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.white70),
          ),
          const Spacer(flex: 4),
          Divider(),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              left: kHorizontalPadding,
              right: kHorizontalPadding,
            ),
            child: CustomButton(
              text: 'OK, Great!',
              onPressed: onOkGreatPressed,
            ),
          ),
        ],
      ),
    );
  }
}
