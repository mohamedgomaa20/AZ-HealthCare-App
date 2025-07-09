import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';

class BasicInformation extends StatefulWidget {
  const BasicInformation({super.key});

  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
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
            "Basic Information",
            style: AppTextStyles.bold30,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
          CustomTextFormField(
            labelText: "First Name",
            hintText: "Enter your first name",
            onChanged: (value) => cubit.updateFirstName(value),

            keyboardType: TextInputType.name,
            controller: cubit.firstNameController,
          ),

          SizedBox(height: 20),
          CustomTextFormField(
            labelText: "Last Name",
            hintText: "Enter your last name",
            keyboardType: TextInputType.name,
            controller: cubit.lastNameController,
            onChanged: (value) => cubit.updateLastName(value),
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            labelText: "Address",
            hintText: "Enter your address",
            keyboardType: TextInputType.streetAddress,
            controller: cubit.addressController,
            onChanged: (value) => cubit.updateAddress(value),
          ),
          SizedBox(height: 20),
          CustomTextFormField(
            labelText: "Phone Number",
            hintText: "Enter your phone name",
            keyboardType: TextInputType.phone,
            controller: cubit.phoneNumberController,
            onChanged: (value) => cubit.updatePhoneNumber(value),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }


}
