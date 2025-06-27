import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../register_cubit/register_cubit.dart';

class SignUpFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController userNameController;

  final TextEditingController emailController;

  final TextEditingController createPasswordController;

  final TextEditingController confirmPasswordController;

  const SignUpFormFields({
    super.key,
    required this.formKey,
    required this.userNameController,
    required this.emailController,
    required this.createPasswordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("UserName", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "UserName",
            controller: userNameController,
            keyboardType: TextInputType.name,
            prefixIconData: CupertinoIcons.profile_circled,
            validation: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'UserName is required';
              }
              if (p0.length < 3) {
                return 'UserName must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text("Email", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIconData: Icons.email,
            onChanged: (value) => cubit.onEmailChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text("Create Password", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Create Password",
            controller: createPasswordController,
            keyboardType: TextInputType.visiblePassword,
            prefixIconData: Icons.lock,
            suffixIconData: cubit.suffixIconCreatePassword,
            suffixOnPressed: cubit.toggleCreatePasswordVisibility,
            isPassword: cubit.isCreatePassword,
            onChanged: (value) => cubit.onCreatePasswordChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }

              final hasUppercase = value.contains(RegExp(r'[A-Z]'));
              final hasLowercase = value.contains(RegExp(r'[a-z]'));
              final hasDigit = value.contains(RegExp(r'[0-9]'));
              final hasSpecialChar = value.contains(
                RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
              );

              if (!hasUppercase) {
                return 'Password must include an uppercase letter';
              }
              if (!hasLowercase) {
                return 'Password must include a lowercase letter';
              }
              if (!hasDigit) {
                return 'Password must include a number';
              }
              if (!hasSpecialChar) {
                return 'Password must include a special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text("Confirm Password", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Confirm Password",
            controller: confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            prefixIconData: Icons.lock,
            suffixIconData: cubit.suffixIconConfirmPassword,
            suffixOnPressed: cubit.toggleConfirmPasswordVisibility,
            isPassword: cubit.isConfirmPassword,
            onChanged: (value) => cubit.onConfirmPasswordChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirm Password is required';
              }
              if (value != createPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
