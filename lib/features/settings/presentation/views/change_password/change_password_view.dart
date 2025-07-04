import 'package:az_health_care/features/settings/presentation/views/change_password/widgets/change_password_view_body.dart';
import 'package:flutter/material.dart';

import '../send_email/send_email_view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  static const String routeName = "changePasswordView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChangePasswordViewBody());
  }
}
