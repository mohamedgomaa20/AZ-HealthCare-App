import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helper_functions/unit_picker_helper.dart';

class HeightSection extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String> onChanged;

  const HeightSection({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "Height",
      value: selectedUnit,
      onTap:
          () => showUnitPicker(
        context: context,
        title: 'Height Unit',
        items: ['cm', 'ft'],
        selected: selectedUnit,
        onSelected: onChanged,
      ),
    );
  }
}
