import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper_functions/unit_picker_helper.dart';

class FirstDaySection extends StatelessWidget {
  final String selectedDay;
  final ValueChanged<String> onChanged;

  const FirstDaySection({
    super.key,
    required this.selectedDay,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "First Day of Week",
      value: selectedDay,
      onTap:
          () => showUnitPicker(
        context: context,
        title: 'First Day of Week',
        items: [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday',
        ],
        selected: selectedDay,
        onSelected: onChanged,
      ),
    );
  }
}
