import 'package:az_health_care/features/home/presentation/views/personal_info/widgets/gender_selector.dart';
import 'package:az_health_care/features/home/presentation/views/personal_info/widgets/profile_image_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../personal_info_cubit/personal_info_cubit.dart';
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
            GenderSelector(),

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

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.semiBold16);
  }
}
