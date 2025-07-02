import 'package:az_health_care/features/help_and_support/presentation/views/f_and_q/widgets/f_and_q_view_body.dart';
import 'package:flutter/material.dart';

class FAndQView extends StatelessWidget {
  const FAndQView({super.key});

  static const routeName = 'fAndQView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FAndQViewBody());
  }
}
