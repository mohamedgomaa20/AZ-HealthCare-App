import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/blood_pressure_card.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/calories_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/header_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/heart_disease_card.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/heart_rate_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/steps_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/water_intake_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/widgets/welcome_section.dart';
import 'package:az_health_care/features/on_boarding/presentation/views/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../step_tracker_v2/manager/step_tracker_cubit/step_tracker_cubit.dart';
import '../../../manager/home_cubit/home_cubit.dart';
import '../../../manager/home_cubit/home_states.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  static const routeName = "homeView";
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(),
              SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const WelcomeSection(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueGrayBackground2,
                        borderRadius: BorderRadius.circular(
                          kPrimaryBorderRadius,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Active Tracking",
                            style: AppTextStyles.semiBold18.copyWith(
                              color: AppColors.grayColor,
                            ),
                          ),
                          BlocBuilder<HomeCubit, HomeStates>(
                            builder: (context, state) {
                              return Switch(
                                activeColor: AppColors.greenColor,
                                value: cubit.valueOfSwitch,
                                onChanged: (value) {
                                  cubit.changeSwitchOfActivation();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<HomeCubit, HomeStates>(
                      builder: (context, state) {
                        return SizedBox(
                          height: 340,
                          child: PageView(
                            controller: pageController,
                            children: [
                              BloodPressureCard(),
                              HeartRateWidget(),
                              HeartDiseaseCard(),
                            ],
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: CustomIndicator(
                        count: 3,
                        dotColor: AppColors.primaryColor,
                        pageController: pageController,
                      ),
                    ),
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
