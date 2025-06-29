import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
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
    return BlocBuilder<
      OnboardingProfileSetupCubit,
      OnboardingProfileSetupStates
    >(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                "When would you like to\nreceive health check reminders?",
                textAlign: TextAlign.center,
                style: AppTextStyles.bold30,
              ),
               Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    CustomWheelPicker(
                      controller: cubit.hourController!,
                      items: cubit.hours,
                      onSelectedItemChangedCallback: cubit.onHourChanged,
                      currentScrollIndex: cubit.currentHourIndex,
                      pickerWidth: 105,
                    ),
                    Text(":", style: AppTextStyles.bold48),
                    CustomWheelPicker(
                      controller: cubit.minuteController!,
                      items: cubit.minutes,
                      onSelectedItemChangedCallback: cubit.onMinuteChanged,
                      currentScrollIndex: cubit.currentMinuteIndex,
                      pickerWidth: 105,
                    ),
                    const SizedBox(width: 12),
                    CustomWheelPicker(
                      controller: cubit.periodController!,
                      items: cubit.periods,
                      onSelectedItemChangedCallback: cubit.onPeriodChanged,
                      currentScrollIndex: cubit.currentPeriodIndex,
                      pickerWidth: 105,
                    ),
                  ],
                ),
              ),
              Text(
                'You can always change this later.',
                style: AppTextStyles.regular14,
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
