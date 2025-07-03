import 'package:flutter/material.dart';
import '../widgets/custom_picker_bottom_sheet.dart';

Future<void> showUnitPicker({
  required BuildContext context,
  required String title,
  required List<String> items,
  required String selected,
  required ValueChanged<String> onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) => CustomPickerBottomSheet(
      title: title,
      items: items,
      initialValue: selected,
      onConfirm: onSelected,
    ),
  );
}
