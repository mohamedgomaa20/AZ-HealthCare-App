
import 'package:az_health_care/features/settings/presentation/views/send_email/widgets/send_email_view_body.dart';
import 'package:flutter/material.dart';

class SendEmailView extends StatelessWidget {
  static const String routeName = 'sendEmailView';

  const SendEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SendEmailViewBody(),
    );
  }
}