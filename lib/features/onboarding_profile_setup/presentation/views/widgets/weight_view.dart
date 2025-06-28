import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/custom_wheel_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingProfileSetupCubit, OnboardingProfileSetupStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "What's your body weight?",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              Center(child: _buildUnitToggle(context)),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWheelPicker(
                        controller: cubit.weightController,
                        items: cubit.weights.map((w) => w.toStringAsFixed(0)).toList(),
                        onSelectedItemChangedCallback: cubit.onWeightChanged,
                        currentScrollIndex: cubit.currentWeightIndex,
                        pickerWidth: 100,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        cubit.selectedWeightUnit,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
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
      },
    );
  }

  Widget _buildUnitToggle(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUnitButton(context, 'kg'),
          _buildUnitButton(context, 'lb'),
        ],
      ),
    );
  }

  Widget _buildUnitButton(BuildContext context, String unit) {
    final isSelected = cubit.selectedWeightUnit == unit;
    return GestureDetector(
      onTap: () {
        cubit.onWeightUnitChanged(unit);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          unit.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
