import 'package:flutter/material.dart';
import 'package:http/http.dart' as context;

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';

class PhysicalInformation extends StatefulWidget {
  const PhysicalInformation({super.key});

  @override
  State<PhysicalInformation> createState() => _PhysicalInformationState();
}

class _PhysicalInformationState extends State<PhysicalInformation> {
  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            "Physical Information",
            style: AppTextStyles.bold30,
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 1),
          CustomTextFormField(
            labelText: "Age",
            hintText: "Enter your age",
            keyboardType: TextInputType.number,
            controller: cubit.ageController,
            onChanged: (value) => cubit.updateAge(value),
          ),

          SizedBox(height: 20),
          CustomTextFormField(
            labelText: "Height(cm)",
            hintText: "Enter your height",
            keyboardType: TextInputType.number,
            controller: cubit.heightController,
            onChanged: (value) => cubit.updateHeight(value),
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            labelText: "Weight(kg)",
            hintText: "Enter your weight",
            keyboardType: TextInputType.number,
            controller: cubit.weightController,
            onChanged: (value) => cubit.updateWeight(value),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }


}
