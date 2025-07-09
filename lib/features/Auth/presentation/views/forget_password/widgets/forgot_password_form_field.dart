import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../manger/forget_password_cubit/forget_password_cubit.dart';


class ForgotPasswordFormField extends StatelessWidget {
  const ForgotPasswordFormField({super.key, required this.controller,required this.formKey});

  final TextEditingController controller;
  final GlobalKey<FormState> formKey ;

  @override
  Widget build(BuildContext context) {
    final cubit = ForgotPasswordCubit.get(context);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: CustomTextFormField(
        hintText: "Email",
        keyboardType: TextInputType.emailAddress,
        controller: controller,
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
    );
  }
}
