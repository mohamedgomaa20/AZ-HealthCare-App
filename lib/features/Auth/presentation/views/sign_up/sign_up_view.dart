import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const routeName = "signUpView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       body: SignUpViewBody(),
    );
  }
}
