import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/onboarding_profile_setup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';

class OnboardingProfileSetupView extends StatelessWidget {
  const OnboardingProfileSetupView({super.key});

  static const String routeName = "onboardingProfileSetupView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              OnboardingProfileSetupCubit()
                ..initBirthdayControllers()
                ..initWeightPicker()
                ..initNameController(null),
      child:   const OnboardingProfileSetupViewBody(),

    );
  }
}
