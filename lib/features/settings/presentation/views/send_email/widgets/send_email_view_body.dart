import 'package:az_health_care/features/settings/presentation/views/send_email/widgets/send_email_footer.dart';
import 'package:az_health_care/features/settings/presentation/views/send_email/widgets/send_email_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:az_health_care/core/widgets/auth_nested_scroll_view.dart';
import 'package:az_health_care/core/services/show_toast.dart';

import '../../../../manager/send_email_cubit/send_email_cubit.dart';
import '../../../../manager/send_email_cubit/send_email_states.dart';

class SendEmailViewBody extends StatelessWidget {
  SendEmailViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  final toEmailController = TextEditingController();
  final subjectController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SendEmailCubit(),
      child: BlocConsumer<SendEmailCubit, SendEmailStates>(
        listener: (context, state) {
          if (state is SendEmailSuccessState) {
            ToastHelper.showToast(
              msg: "Email sent successfully",
              state: ToastStates.SUCCESS,
            );
            Navigator.pop(context);
          }
          if (state is SendEmailErrorState) {
            ToastHelper.showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          final cubit = SendEmailCubit.get(context);

          return AuthNestedScrollView(
            appBarTitle: 'Send Email 📧',
            descriptionText: "Compose and send your email message",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SendEmailFormFields(
                  formKey: formKey,
                  toEmailController: toEmailController,
                  subjectController: subjectController,
                  bodyController: bodyController,
                ),
                const SizedBox(height: 20),
                SendEmailFooter(
                  isValid: cubit.isFormValid,
                  condition: state is! SendEmailLoadingState,
                  formKey: formKey,
                  toEmailController: toEmailController,
                  subjectController: subjectController,
                  bodyController: bodyController,
                  onSendPressed: (toEmail, subject, body) {
                    cubit.sendEmail(
                      toEmail: toEmail,
                      subject: subject,
                      body: body,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
