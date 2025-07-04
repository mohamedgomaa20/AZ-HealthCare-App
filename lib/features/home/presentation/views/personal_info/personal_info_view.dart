import 'package:az_health_care/features/home/presentation/views/personal_info/personal_info_cubit/personal_info_cubit.dart';
import 'package:az_health_care/features/home/presentation/views/personal_info/widgets/personal_info_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});
  static const String routeName = 'personal_Info_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalInfoCubit(),
      child: const PersonalInfoViewBody(),
    );
  }
}
