import 'package:az_health_care/features/get_start/presentation/views/widgets/get_start_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class GetStartView extends StatelessWidget {
  static const routeName = "getStart";

  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: GetStartViewBody(),
    );
  }
}
