import 'package:az_health_care/features/home/manager/personal_info_cubit/personal_info_cubit.dart';
import 'package:az_health_care/features/home/manager/personal_info_cubit/personal_info_state.dart';
import 'package:az_health_care/features/home/presentation/views/profile/widgets/setting_menu_section.dart';
import 'package:az_health_care/features/home/presentation/views/profile/widgets/upgrade_profile_card.dart';
import 'package:az_health_care/features/onboarding_profile_setup/manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import 'package:az_health_care/features/onboarding_profile_setup/manager/profile_setup_cubit/onboarding_profile_setup_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../Auth/manger/register_cubit/register_cubit.dart';
import '../../../../../Auth/manger/register_cubit/register_states.dart';
import '../../../../../upgrade/presentation/views/upgrade_plan/upgrade_plan_view.dart';

import '../personal_info/personal_info_view.dart';
import 'build_profile_app_bar.dart';
import 'build_user_profile_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PersonalInfoCubit.get(context);
        if (state is PersonalInfoLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cubit.userData == null) {
          cubit.fetchUserData();
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Column(
            children: [
              BuildProfileAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        UpgradeProfileCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpgradePlanView(),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 15),

                        BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                          builder: (context, state) {
                            var cubit = PersonalInfoCubit.get(context);
                            return BuildUserProfileCard(
                              onTap: () {
                                cubit.fetchUserData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PersonalInfoView(),
                                  ),
                                );
                              },
                              name: cubit.userData?.userName ?? "userName",
                              email: cubit.userData?.email ?? "user@gmail.com",
                            );
                          },
                        ),
                        SizedBox(height: 15),
                        SettingsMenuSection(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
