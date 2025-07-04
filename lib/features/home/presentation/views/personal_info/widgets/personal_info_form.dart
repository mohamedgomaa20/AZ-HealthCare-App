import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_modal_controller.dart';
import 'package:az_health_care/features/home/presentation/views/personal_info/widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/build_gender_option.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../onboarding_profile_setup/presentation/views/widgets/gender_view.dart';
import '../personal_info_cubit/personal_info_cubit.dart';
import '../personal_info_cubit/personal_info_state.dart';
import 'custom_date_field.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileImagePicker(),
            const SizedBox(height: 15),
            _buildLabel('Full Name'),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintText: 'Enter your full name',
              keyboardType: TextInputType.name,
              prefixIconData: Icons.person,
              controller: cubit.fullNameController,
              validation:
                  (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Please enter your full name'
                          : null,
            ),
            const SizedBox(height: 20),
            _buildLabel('Email'),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              controller: cubit.emailController,
              prefixIconData: Icons.email_outlined,
              validation: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}\$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildLabel('Phone Number'),
            const SizedBox(height: 8),
            CustomTextFormField(
              hintText: '+1 (646) 555-4099',
              keyboardType: TextInputType.phone,
              controller: cubit.phoneController,
              prefixIconData: Icons.call,
              validation:
                  (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Please enter your phone number'
                          : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Gender'),
            const SizedBox(height: 8),
            BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    Gender tempGender = cubit.selectedGender;
                    showCustomModalBottomSheet(
                      context: context,
                      title: 'Choose Gender',
                      confirmText: 'Save',
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onConfirm: () {
                        cubit.changeGender(tempGender);
                        Navigator.pop(context);
                      },
                      isHasButtons: true,
                      centerWidget: StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BuildGenderOption(
                                    context: context,
                                    gender: Gender.male,
                                    label: 'Male',
                                    icon: Icons.male,
                                    isSelected: tempGender == Gender.male,
                                    onTap:
                                        () => setState(
                                          () => tempGender = Gender.male,
                                        ),
                                  ),
                                  BuildGenderOption(
                                    context: context,
                                    gender: Gender.female,
                                    label: 'Female',
                                    icon: Icons.female,
                                    isSelected: tempGender == Gender.female,
                                    onTap:
                                        () => setState(
                                          () => tempGender = Gender.female,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      tempGender == Gender.preferNotToSay
                                          ? AppColors.primaryColor
                                          : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: AppColors.grayColor,
                                    ),
                                  ),
                                ),
                                onPressed:
                                    () => setState(
                                      () => tempGender = Gender.preferNotToSay,
                                    ),
                                child: Text(
                                  'Prefer not to say',
                                  style: AppTextStyles.bold16.copyWith(
                                    color:
                                        tempGender == Gender.preferNotToSay
                                            ? AppColors.whiteColor
                                            : AppColors.white70Color,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.blueGrayBackground2,
                      borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.male,
                          size: 40,
                          color: AppColors.white70Color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          _getGenderLabel(cubit.selectedGender),
                          style: AppTextStyles.semiBold16.copyWith(
                            color: AppColors.white70Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            _buildLabel('Date of Birth'),
            const SizedBox(height: 8),
            const CustomDateField(),
            const SizedBox(height: 40),
            CustomButton(
              text: "Update Profile",
              onPressed: () => cubit.updateProfile(),
            ),
          ],
        ),
      ),
    );
  }

  String _getGenderLabel(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.semiBold16);
  }
}
