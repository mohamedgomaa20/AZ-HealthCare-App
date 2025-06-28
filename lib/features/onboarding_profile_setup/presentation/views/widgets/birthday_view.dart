import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/custom_wheel_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';

class BirthdayView extends StatefulWidget {
  const BirthdayView({super.key});

  @override
  State<BirthdayView> createState() => _BirthdayViewState();
}

class _BirthdayViewState extends State<BirthdayView> {
  late OnboardingProfileSetupCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = OnboardingProfileSetupCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.jumpToSelectedBirthdayItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      OnboardingProfileSetupCubit,
      OnboardingProfileSetupStates
    >(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "When is your birthday?",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        CustomWheelPicker(
                           controller: cubit.monthController,
                          items: cubit.months,
                          onSelectedItemChangedCallback: cubit.onMonthChanged,
                          currentScrollIndex: cubit.currentMonthIndex,
                          pickerWidth: 100,
                        ),
                      ],
                    ),
                    CustomWheelPicker(
                      controller: cubit.dayController,
                      items: cubit.days,
                      onSelectedItemChangedCallback: cubit.onDayChanged,
                      currentScrollIndex: cubit.currentDayIndex,
                      pickerWidth: 100,
                    ),
                    CustomWheelPicker(
                      controller: cubit.yearController,
                      items: cubit.years,
                      onSelectedItemChangedCallback: cubit.onYearChanged,
                      currentScrollIndex: cubit.currentYearIndex,
                      pickerWidth: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
