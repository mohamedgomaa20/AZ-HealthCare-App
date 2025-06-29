import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/customLoadingButton.dart';


class SendEmailFooter extends StatelessWidget {
  const SendEmailFooter({
    super.key,
    required this.isValid,
    required this.condition,
    required this.formKey,
    required this.toEmailController,
    required this.subjectController,
    required this.bodyController,
    required this.onSendPressed,
  });

  final bool isValid;
  final bool condition;
  final GlobalKey<FormState> formKey;
  final TextEditingController toEmailController;
  final TextEditingController subjectController;
  final TextEditingController bodyController;
  final void Function(String toEmail, String subject, String body)
  onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ConditionalBuilder(
          condition: condition,
          builder:
              (context) => CustomButton(
                text: "Send Email",
                icon: Icons.send,
                onPressed:
                    isValid
                        ? () {
                          if (formKey.currentState!.validate()) {
                            onSendPressed(
                              toEmailController.text.trim(),
                              subjectController.text.trim(),
                              bodyController.text.trim(),
                            );
                          }
                        }
                        : null,
              ),
          fallback: (context) => const CustomLoadingButton(),
        ),


        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
        ),
      ],
    );
  }
}
