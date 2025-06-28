import 'package:az_health_care/features/Auth/presentation/views/all_set_password/all_set_password_view.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, AccountSetupFlow.routeName);
          Navigator.pushNamed(context, AllSetPasswordView.routeName);
        },
        child: Icon(Icons.cloud_download),
      ),
    );
  }
}
