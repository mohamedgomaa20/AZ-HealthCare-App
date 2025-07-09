import 'package:az_health_care/features/Auth/presentation/views/login/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/custom_password_form_field.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../manger/login_cubit/login_cubit.dart';

class LoginFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text("Password", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Password",
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            prefixIconData: Icons.lock,
            suffixIconData: cubit.suffixIcon,
            suffixOnPressed: cubit.togglePasswordVisibility,
            isPassword: cubit.isPassword,
            onChanged: (value) => cubit.onPasswordChanged(value),
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

          const SizedBox(height: 10),
          RememberMeAndForgetPasswordRow(
            isRememberMe: cubit.isRememberMe,
            onRememberMeChanged: (p0) => cubit.toggleRememberMe(),
          ),
        ],
      ),
    );
  }
}
