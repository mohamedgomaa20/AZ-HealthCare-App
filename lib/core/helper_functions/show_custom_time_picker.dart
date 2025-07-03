import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  TimeOfDay? initialTime,
  bool use24HourFormat = false,
}) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime ?? TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primaryColor,
            surface: AppColors.blueGrayBackground2,
            onSurface: Colors.white,
          ),
          timePickerTheme: TimePickerThemeData(
            dayPeriodColor: WidgetStateColor.resolveWith(
              (states) =>
                  states.contains(WidgetState.selected)
                      ? AppColors.primaryColor
                      : AppColors.white10Color,
            ),
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(alwaysUse24HourFormat: use24HourFormat),
          child: child!,
        ),
      );
    },
  );

  return picked;
}
