 import 'package:az_health_care/features/Auth/presentation/views/welcome_to_a2z_care/widgets/welcome_to_a2z_care_view_body.dart';
import 'package:flutter/material.dart';


class WelcomeToA2zCareView extends StatelessWidget {
  const WelcomeToA2zCareView({super.key});

  static const routeName = "welcomeToA2zCare";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WelcomeToA2zCareViewBody(),
    );
  }
}
