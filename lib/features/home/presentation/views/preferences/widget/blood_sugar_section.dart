import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/helper_functions/unit_picker_helper.dart';

class BloodSugarSection extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String> onChanged;

  const BloodSugarSection({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "Blood Sugar",
      value: selectedUnit,
      onTap:
          () => showUnitPicker(
        context: context,
        title: 'Blood Sugar Unit',
        items: ['mg/dL', 'mmol/L'],
        selected: selectedUnit,
        onSelected: onChanged,
      ),
    );
  }
}
