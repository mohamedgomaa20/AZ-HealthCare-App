import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/build_gender_option.dart';
import '../../../../../../core/widgets/custom_modal_controller.dart';
import '../../../../../onboarding_profile_setup/presentation/views/widgets/gender_view.dart';
import '../personal_info_cubit/personal_info_cubit.dart';
import '../personal_info_cubit/personal_info_state.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: AppTextStyles.semiBold16),

        const SizedBox(height: 8),
        BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                showCustomModalBottomSheet(
                  context: context,
                  title: 'Choose Gender',
                  confirmText: 'Save',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {
                    cubit.confirmTempGender();
                    Navigator.pop(context);
                  },
                  isHasButtons: true,
                  centerWidget: BlocProvider.value(
                    value: cubit,
                    child: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                      builder: (context, _) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BuildGenderOption(
                                  context: context,
                                  gender: Gender.male,
                                  label: 'Male',
                                  icon: Icons.male,
                                  isSelected:
                                      cubit.tempSelectedGender == Gender.male,
                                  onTap: () => cubit.setTempGender(Gender.male),
                                ),
                                BuildGenderOption(
                                  context: context,
                                  gender: Gender.female,
                                  label: 'Female',
                                  icon: Icons.female,
                                  isSelected:
                                      cubit.tempSelectedGender == Gender.female,
                                  onTap:
                                      () => cubit.setTempGender(Gender.female),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    cubit.tempSelectedGender ==
                                            Gender.preferNotToSay
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: AppColors.grayColor),
                                ),
                              ),
                              onPressed:
                                  () => cubit.setTempGender(
                                    Gender.preferNotToSay,
                                  ),
                              child: Text(
                                'Prefer not to say',
                                style: AppTextStyles.bold16.copyWith(
                                  color:
                                      cubit.tempSelectedGender ==
                                              Gender.preferNotToSay
                                          ? AppColors.whiteColor
                                          : AppColors.white70Color,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.blueGrayBackground2,
                  borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
                ),
                child: Row(
                  children: [
                    Icon(Icons.male, size: 40, color: AppColors.white70Color),
                    const SizedBox(width: 5),
                    Text(
                      _getGenderLabel(cubit.selectedGender),
                      style: AppTextStyles.semiBold16.copyWith(
                        color: AppColors.white70Color,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _getGenderLabel(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }
}
