import 'package:az_health_care/features/upgrade/presentation/views/congratulations/widgets/congratulations_view_body.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class CongratulationsView extends StatelessWidget {
  const CongratulationsView({super.key});

  static const routeName = 'congratulationsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: const CongratulationsViewBody(),
    );
  }
}
