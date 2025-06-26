import 'package:az_health_care/features/Auth/presentation/views/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = "loginView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: LoginViewBody(),
    );
  }
}
