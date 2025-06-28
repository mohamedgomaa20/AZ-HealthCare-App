import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';
 import 'custom_toggle_selector.dart';
import 'custom_wheel_picker.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  late OnboardingProfileSetupCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = OnboardingProfileSetupCubit.get(context);
    cubit.initReminderPicker();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.hourController?.jumpToItem(cubit.currentHourIndex);
      cubit.minuteController?.jumpToItem(cubit.currentMinuteIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingProfileSetupCubit, OnboardingProfileSetupStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                "When would you like to\nreceive health check reminders?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),
              CustomToggleSelector(
                options: const ['AM', 'PM'],
                selectedOption: cubit.selectedPeriod,
                onOptionSelected: cubit.onAmPmChanged,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomWheelPicker(
                      controller: cubit.hourController!,
                      items: cubit.hours,
                      onSelectedItemChangedCallback: cubit.onHourChanged,
                      currentScrollIndex: cubit.currentHourIndex,
                      pickerWidth: 150,
                     ),
                    Text(
                      ":",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 48),
                    ),
                    CustomWheelPicker(
                      controller: cubit.minuteController!,
                      items: cubit.minutes,
                      onSelectedItemChangedCallback: cubit.onMinuteChanged,
                      currentScrollIndex: cubit.currentMinuteIndex,
                      pickerWidth: 150,
                     ),
                  ],
                ),
              ),
              Text(
                'You can always change this later.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
