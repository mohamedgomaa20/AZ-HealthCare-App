import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/reminder_view.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/weight_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../layout/app_layout.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'birthday_view.dart';
import '../../../../../core/widgets/custom_loading_dialog.dart';
import 'gender_view.dart';
import 'height_view.dart';
import 'name_view.dart';

class OnboardingProfileSetupViewBody extends StatelessWidget {
  const OnboardingProfileSetupViewBody({super.key});

  List<Widget> _getPages(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);

    return [
      NameView(key: const PageStorageKey('NameScreen')),

      GenderView(
        key: const PageStorageKey('GenderScreen'),
        selectedGender: cubit.selectedGender,
        onGenderSelected: (gender) {
          switch (gender) {
            case Gender.male:
              cubit.updateGender("Male");
              break;
            case Gender.female:
              cubit.updateGender("Female");
              break;
            case Gender.preferNotToSay:
              cubit.updateGender("PreferNotToSay");
              break;
          }
        },
      ),

      const BirthdayView(key: PageStorageKey('BirthdayScreen')),
      WeightView(key: const PageStorageKey('WeightScreen')),
      HeightView(key: const PageStorageKey('HeightScreen')),
      ReminderView(key: const PageStorageKey('ReminderScreen')),
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
            title: Expanded(
              child: Padding(
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
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding,
                    vertical: 16,
                  ),
                  child: CustomButton(
                    text: isLast ? 'Finish' : 'Continue',
                    onPressed: () {
                      if (cubit.currentPage == 0 && !cubit.isNameValid()) {
                        ToastHelper.showToast2(
                          context: context,
                          msg: "Please enter your name",
                          state: ToastStates.ERROR,
                        );

                        return;
                      }
                      if (cubit.currentPage == 1 &&
                          cubit.selectedGender == null) {
                        ToastHelper.showToast2(
                          context: context,
                          msg: "Please select your gender",
                          state: ToastStates.ERROR,
                        );
                        return;
                      }
                      if (isLast) {
                        cubit.submitUserData();

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (_) => CustomLoadingDialog(
                                message: 'Creating your account...',
                                onComplete: () async {
                                  ToastHelper.showToast2(
                                    context: context,
                                    msg: 'Account creation successful.',
                                    state: ToastStates.SUCCESS,
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeLayout(),
                                    ),
                                  );
                                },
                              ),
                        );

                        // cubit.submitUserData();
                        // showDialog(
                        //   context: context,
                        //   barrierDismissible: false,
                        //   builder: (_) => const CreatingAccountDialogLoading(),
                        // );
                      } else {
                        cubit.goToNextPage(pages.length);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
