import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper_functions/unit_picker_helper.dart';

class TimeFormatSection extends StatelessWidget {
  final String selectedFormat;
  final ValueChanged<String> onChanged;

  const TimeFormatSection({
    super.key,
    required this.selectedFormat,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "Time Format",
      value: selectedFormat,
      onTap:
          () => showUnitPicker(
        context: context,
        title: 'Time Format',
        items: ['System Default', '12 Hour', '24 Hour'],
        selected: selectedFormat,
        onSelected: onChanged,
      ),
    );
  }
}
