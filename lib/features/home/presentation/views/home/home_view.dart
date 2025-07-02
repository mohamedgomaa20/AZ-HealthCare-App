import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/calories_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/header_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/heart_rate_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/steps_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/water_intake_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/welcome_section.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = "homeView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const WelcomeSection(),
                    HeartRateWidget(),
                    const Row(
                      children: [
                        Expanded(child: StepsWidget()),
                        Expanded(child: WaterIntakeWidget()),
                      ],
                    ),
                    const CaloriesWidget(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
