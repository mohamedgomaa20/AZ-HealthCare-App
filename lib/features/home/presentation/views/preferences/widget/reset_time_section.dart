import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper_functions/show_custom_time_picker.dart';

class ResetTimeSection extends StatelessWidget {
  final String currentTime;
  final ValueChanged<String> onChanged;

  const ResetTimeSection({
    super.key,
    required this.currentTime,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "Day Reset Time",
      value: currentTime,
      onTap: () async {
        final TimeOfDay? picked = await showCustomTimePicker(context: context);
        if (picked != null) {
          onChanged(picked.format(context));
        }
      },
    );
  }
}
