import 'package:az_health_care/features/home/presentation/views/profile/personal_info/widgets/personal_info_form.dart';
import 'package:flutter/material.dart';

import '../../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';

class PersonalInfoViewBody extends StatelessWidget {
  const PersonalInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: const [
            CustomAppBar(title: 'Personal Info'),
            SizedBox(height: 15),
            Expanded(child: PersonalInfoForm()),
          ],
        ),
      ),
    );
  }
}
