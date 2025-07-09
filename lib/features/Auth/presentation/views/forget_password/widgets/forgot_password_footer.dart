import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/customLoadingButton.dart';

import '../../../../manger/forget_password_cubit/forget_password_cubit.dart';

class ForgotPasswordFooter extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool condition;
  final void Function(String email) onPressed;

  const ForgotPasswordFooter({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.condition,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = ForgotPasswordCubit.get(context);

    return ConditionalBuilder(
      condition: condition,
      builder:
          (context) => CustomButton(
            text: "Send Reset Link",
            onPressed:
                cubit.isEmailValid
                    ? () {
                      if (formKey.currentState!.validate()) {
                        onPressed(emailController.text);
                      }
                    }
                    : null,
          ),
      fallback: (context) => const CustomLoadingButton(),
    );
  }
}
