import 'dart:ui';
import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class CustomLoadingDialog extends StatefulWidget {
  final String message;
  final Future<void> Function() onComplete;
  final Duration delay;

  const CustomLoadingDialog({
    super.key,
    required this.message,
    required this.onComplete,
    this.delay = const Duration(seconds: 3),
  });

  @override
  State<CustomLoadingDialog> createState() => _CustomLoadingDialogState();
}

class _CustomLoadingDialogState extends State<CustomLoadingDialog> {
  @override
  void initState() {
    super.initState();
    _startDelayAndExecute();
  }

  void _startDelayAndExecute() async {
    await Future.delayed(widget.delay);
    if (!mounted) return;
    Navigator.of(context).pop();
    await widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: AppColors.blackColor.withValues(alpha: 0.4),
            ),
          ),

          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.22,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),

              decoration: BoxDecoration(
                color: AppColors.blueGrayBackground,
                borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
