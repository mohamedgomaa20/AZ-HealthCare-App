import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../personal_info_cubit/personal_info_cubit.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);
    return CustomTextFormField(
      keyboardType: TextInputType.datetime,
      controller: cubit.dobController,
      prefixIconData: Icons.date_range,
      readOnly: true,
      hintText: 'MM-DD-YYYY',
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime(1995, 12, 27),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: AppColors.primaryColor,
                  surface: AppColors.blueGrayBackground2,
                  onSurface: AppColors.whiteColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
                ),
                dialogTheme: DialogThemeData(
                  backgroundColor: AppColors.blueGrayBackground2,
                ),
              ),
              child: child!,
            );
          },
        ).then((value) {
          cubit.pickDate(value);
        });
      },
    );
  }
}
