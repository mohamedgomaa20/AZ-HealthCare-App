import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../data/home_cubit/home_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          TextButton(
            child: Text("get userdata"),
            onPressed: () {
              HomeCubit.get(context).getUserDataByUserId(userId: "d9fe7ac7-9075-4885-b272-53af9e963c96");
            },
          ),
        ],
      ),
    );
  }
}
