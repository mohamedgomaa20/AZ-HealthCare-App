import 'dart:ui';
import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CreatingAccountDialogLoading extends StatefulWidget {
  const CreatingAccountDialogLoading({super.key});

  @override
  State<CreatingAccountDialogLoading> createState() => _CreatingAccountDialogLoadingState();
}

class _CreatingAccountDialogLoadingState extends State<CreatingAccountDialogLoading> {
  @override
  void initState() {
    super.initState();
     _simulateAccountCreation();
  }

  void _simulateAccountCreation() async {

    // await cubit.createAccount();

    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pop();
      ToastHelper.showToast(msg: "Account creation simulated and dialog closed.", state: ToastStates.SUCCESS);

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeLayout()),
      // );
      print("Account creation simulated and dialog closed.");
    }
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
          // Centered Dialog Content
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * .8,
              height: MediaQuery.sizeOf(context).height * .22,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                   SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Creating your account ...',
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