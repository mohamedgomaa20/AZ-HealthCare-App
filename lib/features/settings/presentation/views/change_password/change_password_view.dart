import 'package:az_health_care/features/Auth/presentation/views/forget_password/widgets/forgot_password_view_body.dart';
import 'package:az_health_care/features/settings/presentation/views/change_password/widgets/change_password_view_body.dart';
 import 'package:flutter/material.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  static const String routeName = "changePasswordView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChangePasswordViewBody());
  }
}
