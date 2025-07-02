import 'package:az_health_care/features/help_and_support/presentation/views/help_and_support/widgets/help_and_support_view_body.dart';
import 'package:az_health_care/features/home/presentation/views/profile/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class HelpAndSupportView extends StatelessWidget {
  const HelpAndSupportView({super.key});

  static const routeName = "helpAndSupportView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HelpAndSupportViewBody());
  }
}
