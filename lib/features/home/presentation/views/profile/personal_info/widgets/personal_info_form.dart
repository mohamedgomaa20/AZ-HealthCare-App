import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/widgets/customLoadingButton.dart';
import 'package:az_health_care/core/widgets/custom_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/custom_button.dart';
import '../../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../onboarding_profile_setup/data/models/OnboardingConstants.dart';
import '../../../../../manager/personal_info_cubit/personal_info_cubit.dart';
import '../../../../../manager/personal_info_cubit/personal_info_state.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);

    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          Navigator.pop(context);
          ToastHelper.showToast2(
            bottomOffset: 80,
            context: context,
            msg: "Successfully updated",
            state: ToastStates.SUCCESS,
          );
          Navigator.pop(context);
        }
        if (state is UpdateProfileErrorState) {
          Navigator.pop(context);
          ToastHelper.showToast2(
            context: context,
            bottomOffset: 100,
            msg: "Something went wrong please try again",
            state: ToastStates.ERROR,
          );
        }
        if (state is UpdateProfileLoadingState) {
          showDialog(
            context: context,
            builder:
                (_) => CustomLoadingDialog(
                  message: 'Updating...',
                  onComplete: () async {},
                ),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                CustomTextFormField(
                  labelText: "First Name",
                  hintText: '',
                  keyboardType: TextInputType.name,
                  prefixIconData: Icons.person,
                  controller: cubit.firstNameController,
                  onChanged: (value) => cubit.updateFirstName(value),
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your first name'
                              : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  labelText: "Last Name",
                  hintText: '',
                  keyboardType: TextInputType.name,
                  prefixIconData: Icons.person,
                  controller: cubit.lastNameController,
                  onChanged: (value) => cubit.updateLastName(value),
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your last name'
                              : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  labelText: "Address",
                  hintText: '',
                  keyboardType: TextInputType.text,
                  prefixIconData: Icons.location_on,
                  controller: cubit.addressController,
                  onChanged: (value) => cubit.updateAddress(value),
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your address'
                              : null,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  labelText: "Phone Number",
                  hintText: '',
                  keyboardType: TextInputType.phone,
                  controller: cubit.phoneNumberController,
                  onChanged: (value) => cubit.updatePhoneNumber(value),
                  prefixIconData: Icons.call,
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your phone number'
                              : null,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  labelText: "Age",
                  hintText: '',
                  keyboardType: TextInputType.number,
                  controller: cubit.ageController,
                  prefixIconData: Icons.calendar_month,
                  onChanged: (value) => cubit.updateAge(value),
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your age'
                              : null,
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  labelText: "Height(cm)",
                  hintText: '',
                  keyboardType: TextInputType.number,
                  controller: cubit.heightController,
                  prefixIconData: Icons.height,
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your height'
                              : null,

                  onChanged: (value) => cubit.updateHeight(value),
                ),
                const SizedBox(height: 20),

                CustomTextFormField(
                  labelText: "Weight(kg)",
                  hintText: '',
                  keyboardType: TextInputType.number,
                  controller: cubit.weightController,
                  prefixIconData: Icons.line_weight,
                  validation:
                      (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Please enter your weight'
                              : null,
                  onChanged: (value) => cubit.updateWeight(value),
                ),
                const SizedBox(height: 20),
                _buildGenderDropdown(cubit),
                const SizedBox(height: 20),
                _buildHealthGoalsDropdown(cubit),
                const SizedBox(height: 40),
                state is UpdateProfileLoadingState
                    ? const CustomLoadingButton()
                    : CustomButton(
                      text: "Update Profile",
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.updateUserProfile();
                        }
                      },
                    ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHealthGoalsDropdown(PersonalInfoCubit cubit) {
    final healthGoalValues =
        OnboardingConstants.healthGoals.map((goal) => goal.goal).toList();

    return DropdownButtonFormField<String>(
      value:
          healthGoalValues.contains(cubit.healthGoal) ? cubit.healthGoal : null,
      dropdownColor: AppColors.blueGrayBackground2,
      padding: EdgeInsets.zero,
      decoration: InputDecoration(
        labelText: "Health Goal",
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
      ),
      items:
          OnboardingConstants.healthGoals.map((goal) {
            return DropdownMenuItem<String>(
              value: goal.goal,
              child: Text(goal.goal),
            );
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          cubit.updateHealthGoal(value);
        }
      },
      isExpanded: true,
    );
  }

  Widget _buildGenderDropdown(PersonalInfoCubit cubit) {
    final genders = ['Male', 'Female', 'PreferNotToSay'];

    return DropdownButtonFormField<String>(
      value: genders.contains(cubit.gender) ? cubit.gender : null,

      // value: (cubit.gender == null || cubit.gender!.isEmpty || !genders.contains(cubit.gender))
      //     ? null
      //     : cubit.gender,
      dropdownColor: AppColors.blueGrayBackground2,
      decoration: InputDecoration(
        labelText: "Gender",

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
      ),
      items:
          genders.map((gender) {
            return DropdownMenuItem<String>(value: gender, child: Text(gender));
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          cubit.updateGender(value);
        }
      },
      isExpanded: true,
    );
  }
}
