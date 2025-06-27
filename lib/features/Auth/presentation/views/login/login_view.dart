import 'package:az_health_care/features/Auth/presentation/views/login/login_cubit/login_states.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import 'login_cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = "loginView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LoginViewBody(),
    );
  }
}
