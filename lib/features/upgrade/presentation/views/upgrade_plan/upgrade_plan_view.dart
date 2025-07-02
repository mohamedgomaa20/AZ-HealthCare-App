 import 'package:az_health_care/features/upgrade/presentation/views/upgrade_plan/widgets/upgrade_pan_view_body.dart';
import 'package:flutter/material.dart';

class UpgradePlanView extends StatelessWidget {
  const UpgradePlanView({super.key});

  static const routeName = 'upgradePlanView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UpgradePanViewBody());
  }
}
