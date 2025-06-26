import 'package:az_health_care/features/get_start/presentation/views/widgets/get_start_view_body.dart';
import 'package:az_health_care/features/personal_info/presentation/views/widgets/personal_info_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class PersonalInfoView extends StatelessWidget {
  static const routeName = "personalInfoView";

  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: PersonalInfoOnBoarding(),
    );
  }
}




