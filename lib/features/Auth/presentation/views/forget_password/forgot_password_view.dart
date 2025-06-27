import 'package:az_health_care/features/Auth/presentation/views/forget_password/widgets/forgot_password_view_body.dart';
 import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const String routeName = "forgotPasswordView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ForgotPasswordViewBody());
  }
}
