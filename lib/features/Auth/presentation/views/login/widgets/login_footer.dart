import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/customLoadingButton.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/switch_auth_text.dart';
import 'package:az_health_care/core/widgets/or_continue_with.dart';
import 'package:az_health_care/features/get_start/presentation/views/widgets/google_button.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
    required this.isValid,
     required this.condition,
    required this.formKey,
    required this.emailController,
    required this.passwordController,

    required this.onLoginPressed,
  });

  final bool isValid;

   final bool condition;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function(String email, String password) onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchAuthText(
          normalText: "Don't have an account? ",
          actionText: "Sign Up",
          onTap: () {
            Navigator.pushReplacementNamed(context, SignUpView.routeName);
          },
        ),
        const SizedBox(height: 20),
        const OrContinueWith(),
        const SizedBox(height: 16),
        const GoogleButton(),
        const SizedBox(height: 32),
        ConditionalBuilder(
          condition: condition,
          builder:
              (context) => CustomButton(
                text: "Log In",
                onPressed:
                    isValid
                        ? () {
                          if (formKey.currentState!.validate()) {
                            onLoginPressed(
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        }
                        : null,
              ),
          fallback: (context) => const CustomLoadingButton(),
        ),
      ],
    );
  }
}
