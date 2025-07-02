 import 'package:az_health_care/features/home/presentation/views/app_appearance/widgets/app_appearance_view_body.dart';
import 'package:flutter/material.dart';

class AppAppearanceView extends StatelessWidget {
  const AppAppearanceView({super.key});
  static const routeName = 'appAppearanceView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: AppAppearanceViewBody(),
    );
  }
}
