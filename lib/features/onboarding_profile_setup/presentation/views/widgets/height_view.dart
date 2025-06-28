 import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/custom_wheel_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_toggle_selector.dart';

class HeightView extends StatefulWidget {
  const HeightView({super.key});

  @override
  State<HeightView> createState() => _HeightViewState();
}

class _HeightViewState extends State<HeightView> {
  late OnboardingProfileSetupCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = OnboardingProfileSetupCubit.get(context);
    cubit.initHeightPicker();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.heightController?.jumpToItem(cubit.currentHeightIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingProfileSetupCubit, OnboardingProfileSetupStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "How tall are you?",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              CustomToggleSelector(
                options: const ['cm', 'ft'],
                selectedOption: cubit.selectedHeightUnit,
                onOptionSelected: cubit.onHeightUnitChanged,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWheelPicker(
                        controller: cubit.heightController!,
                        items: cubit.heights
                            .map((h) => cubit.selectedHeightUnit == 'cm'
                            ? h.toStringAsFixed(0)
                            : cubit.convertCmToFeetAndInches(h))
                            .toList(),
                        onSelectedItemChangedCallback: cubit.onHeightChanged,
                        currentScrollIndex: cubit.currentHeightIndex,
                        pickerWidth: 120,
                        additionalPickerWidth: 80,
                        additionalWidget: Text(
                          cubit.selectedHeightUnit,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
