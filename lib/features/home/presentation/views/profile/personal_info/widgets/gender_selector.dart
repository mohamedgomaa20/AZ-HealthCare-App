import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/constants.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../../core/widgets/custom_modal_controller.dart';
import '../../../../../../onboarding_profile_setup/presentation/views/gender_view.dart';
import '../../../../../manager/personal_info_cubit/personal_info_cubit.dart';
import '../../../../../manager/personal_info_cubit/personal_info_state.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                showCustomModalBottomSheet(
                  context: context,
                  title: 'Gender',
                  confirmText: 'Save',
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () {
                    cubit.gender = cubit.tempSelectedGender;
                    cubit.confirmTempGender();
                    Navigator.pop(context);
                  },
                  isHasButtons: true,
                  centerWidget: BlocProvider.value(
                    value: cubit,
                    child: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
                      builder: (context, _) {
                        return GenderView(
                          showTitle: false,
                          selectedGender: cubit.genderFromLabel(
                            cubit.selectedGender ?? "Male",
                          ),
                          onGenderSelected: cubit.setTempGender,
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
                      cubit.selectedGender ?? "Male",
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
}
