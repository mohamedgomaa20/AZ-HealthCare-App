import 'package:az_health_care/features/home/presentation/views/personal_info/widgets/personal_info_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import '../personal_info_cubit/personal_info_cubit.dart';
import '../personal_info_cubit/personal_info_state.dart';

class PersonalInfoViewBody extends StatelessWidget {
  const PersonalInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: const [
                CustomAppBar(title: 'Personal Info'),
                SizedBox(height: 15),
                Expanded(child: PersonalInfoForm()),
              ],
            ),
          );
        },
      ),
    );
  }
}
