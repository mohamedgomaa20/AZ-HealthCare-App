import 'package:flutter/material.dart';
import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'reminder_container.dart';

class ReminderSettingViewBody extends StatelessWidget {
  const ReminderSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: 'Reminder'),
          SizedBox(height: 15),
          ReminderContainer(),
        ],
      ),
    );
  }
}
