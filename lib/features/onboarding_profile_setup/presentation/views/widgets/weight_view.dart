import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/custom_wheel_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'custom_toggle_selector.dart';

class WeightView extends StatefulWidget {
  const WeightView({super.key});

  @override
  State<WeightView> createState() => _WeightViewState();
}

class _WeightViewState extends State<WeightView> {
  late OnboardingProfileSetupCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = OnboardingProfileSetupCubit.get(context);
    cubit.initWeightPicker();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.weightController!.jumpToItem(cubit.currentWeightIndex);
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
                "What's your body weight?",
                style: AppTextStyles.bold30,
              ),
              const SizedBox(height: 40),
              Center(child: CustomToggleSelector(
                options: ['kg', 'lb'],
                selectedOption: cubit.selectedWeightUnit,
                onOptionSelected: cubit.onWeightUnitChanged,
              ),),

              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWheelPicker(
                        controller: cubit.weightController!,
                        items:
                            cubit.weights
                                .map((w) => w.toStringAsFixed(0))
                                .toList(),
                        onSelectedItemChangedCallback: cubit.onWeightChanged,
                        currentScrollIndex: cubit.currentWeightIndex,
                        pickerWidth: 80,
                        additionalPickerWidth: 60,
                        additionalWidget: Text(
                          cubit.selectedWeightUnit,
                          style: AppTextStyles.bold24.copyWith(
                            color: AppColors.primaryColor
                          ),
                        ),
                      ),
                      //                       const SizedBox(width: 10),
                      // ,
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
