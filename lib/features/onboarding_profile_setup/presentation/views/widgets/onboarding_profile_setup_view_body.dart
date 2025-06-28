import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/reminder_view.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/widgets/weight_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import '../../data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'birthday_view.dart';
import 'creating_account_dialog_loading.dart';
import 'gender_view.dart';
import 'height_view.dart';

class OnboardingProfileSetupViewBody extends StatelessWidget {
  const OnboardingProfileSetupViewBody({super.key});

  List<Widget> _getPages(BuildContext context) {
    final cubit = OnboardingProfileSetupCubit.get(context);

    return [
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
      HeightView(
        key: const PageStorageKey('HeightScreen'),

      ),
      ReminderView(
        key: const PageStorageKey('ReminderScreen'),
        onReminderTimeSelected: cubit.updateReminderTime,
      ),
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
          appBar: AppBar(
            leading:
                cubit.currentPage > 0
                    ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: cubit.goToPreviousPage,
                    )
                    : null,
            title: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: LinearProgressIndicator(
                    value: (cubit.currentPage + 1) / pages.length,
                    backgroundColor: Colors.white12,
                    color: Theme.of(context).primaryColor,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(width: 40),
                Text(
                  '${cubit.currentPage + 1} / ${pages.length}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
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
                      if (isLast) {
                        cubit.submitUserData();
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => const CreatingAccountDialogLoading(),
                        );
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
