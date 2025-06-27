import 'package:az_health_care/features/get_start/presentation/views/widgets/get_start_view_body.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../shared/network/remote/dio_helper.dart';

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
          Navigator.pushNamed(context, HomeLayout.routeName);

        },
        child: Icon(Icons.cloud_download),
      ),
    );
  }
}
