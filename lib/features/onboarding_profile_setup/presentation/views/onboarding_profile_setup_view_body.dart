import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/acitivity_level.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/add_contact_emergency.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/gender_view2.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/health_goal.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/physical_information.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/sensor_data_upload_view.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/manager/personal_info_cubit/personal_info_cubit.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../manager/profile_setup_cubit/onboarding_profile_setup_states.dart';
import '../../manager/sensor_upload_cubit/sensor_upload_cubit.dart';
import '../../manager/sensor_upload_cubit/sensor_upload_states.dart';
import 'basic_information.dart';

class OnboardingProfileSetupViewBody extends StatelessWidget {
  const OnboardingProfileSetupViewBody({super.key});

  List<Widget> _getPages(BuildContext context) {
    return [
      WelcomeView(),
      BasicInformation(),
      PhysicalInformation(),
      GenderView2(),
      ActivityLevel(),
      HealthGoal(),
      AddContactEmergency(),
      SensorDataUploadScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      OnboardingProfileSetupCubit,
      OnboardingProfileSetupStates
    >(
      builder: (context, state) {
        final cubit = OnboardingProfileSetupCubit.get(context);
        final sensorCubit = SensorUploadCubit.get(context);
        final pages = _getPages(context);
        final isLast = cubit.currentPage == pages.length - 1;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading:
                cubit.currentPage > 0
                    ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: cubit.goToPreviousPage,
                    )
                    : null,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding / 2,
              ),
              child: LinearProgressIndicator(
                value: (cubit.currentPage + 1) / pages.length,
                backgroundColor: Colors.white12,
                color: Theme.of(context).primaryColor,
                minHeight: 10,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            actions: [
              Text(
                '${cubit.currentPage + 1} / ${pages.length}',
                style: AppTextStyles.bold24.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: cubit.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: cubit.updateCurrentPage,
                  children: pages,
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.grey.withOpacity(.5),
                  height: .5,
                  width: double.infinity,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: 18,
                  ),
                  child: Row(
                    children: [
                      if (cubit.currentPage > 0)
                        Expanded(
                          child: CustomButton(
                            text: 'Previous',
                            backgroundColor: AppColors.buttonColor,
                            onPressed: cubit.goToPreviousPage,
                          ),
                        ),
                      if (cubit.currentPage > 0) SizedBox(width: 16),
                      BlocBuilder<SensorUploadCubit, SensorUploadState>(
                        builder: (context, state) {
                          return Expanded(
                            child: CustomButton(
                              text: isLast ? 'Finish' : 'Continue',
                              onPressed:
                                  (cubit.canProceed() &&
                                          (cubit.currentPage != 7 ||
                                              sensorCubit.isFileUploaded))
                                      ? () {
                                        if (cubit.currentPage == 6) {
                                          context
                                              .read<PersonalInfoCubit>()
                                              .updateUserProfile();
                                        }
                                        if (isLast) {
                                          Navigator.of(
                                            context,
                                          ).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => HomeLayout(),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        } else {
                                          cubit.nextPage();
                                        }
                                      }
                                      : null,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
