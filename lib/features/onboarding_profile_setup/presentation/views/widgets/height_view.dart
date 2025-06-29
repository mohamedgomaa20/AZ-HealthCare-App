import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/custom_wheel_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
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
              Text("How tall are you?", style: AppTextStyles.bold30),
              const SizedBox(height: 40),
              CustomToggleSelector(
                options: const ['cm', 'ft'],
                selectedOption: cubit.selectedHeightUnit,
                onOptionSelected: cubit.onHeightUnitChanged,
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWheelPicker(
                        controller: cubit.heightController!,
                        items:
                            cubit.heights
                                .map(
                                  (h) =>
                                      cubit.selectedHeightUnit == 'cm'
                                          ? h.toStringAsFixed(0)
                                          : cubit.convertCmToFeetAndInches(h),
                                )
                                .toList(),
                        onSelectedItemChangedCallback: cubit.onHeightChanged,
                        currentScrollIndex: cubit.currentHeightIndex,
                        pickerWidth: 80,
                        additionalPickerWidth: 60,
                        additionalWidget: Text(
                          cubit.selectedHeightUnit,
                          style: AppTextStyles.bold24.copyWith(
                            color: AppColors.primaryColor,
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
