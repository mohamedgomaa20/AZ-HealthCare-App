import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("NotificationViewBody", style: AppTextStyles.bold28));
  }
}
