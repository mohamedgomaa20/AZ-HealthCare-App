import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';

 import '../../../../manager/send_email_cubit/send_email_cubit.dart';
import 'attachments_section.dart';

class SendEmailFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController toEmailController;
  final TextEditingController subjectController;
  final TextEditingController bodyController;

  const SendEmailFormFields({
    super.key,
    required this.formKey,
    required this.toEmailController,
    required this.subjectController,
    required this.bodyController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = SendEmailCubit.get(context);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // To Email Field
          Text("To Email", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "mohamed@example.com",
            controller: toEmailController,
            keyboardType: TextInputType.emailAddress,
            prefixIconData: Icons.email_outlined,
            onChanged: (value) => cubit.onToEmailChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Recipient email is required';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Subject Field
          Text("Subject", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Email subject",
            controller: subjectController,
            keyboardType: TextInputType.text,
            prefixIconData: Icons.subject,
            onChanged: (value) => cubit.onSubjectChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Subject is required';
              }
              if (value.length < 3) {
                return 'Subject must be at least 3 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          // Body Field
          Text("Message", style: AppTextStyles.semiBold16),
          const SizedBox(height: 5),
          CustomTextFormField(
            hintText: "Write your message here...",
            controller: bodyController,
            keyboardType: TextInputType.multiline,
            prefixIconData: Icons.message_outlined,
            maxLines: 6,
            onChanged: (value) => cubit.onBodyChanged(value),
            validation: (value) {
              if (value == null || value.isEmpty) {
                return 'Message body is required';
              }
              if (value.length < 10) {
                return 'Message must be at least 10 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

           AttachmentsSection(),
        ],
      ),
    );
  }
}
