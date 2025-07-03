import 'package:flutter/material.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/helper_functions/show_custom_time_picker.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_picker_bottom_sheet.dart';
import '../../../../../../core/widgets/build_switch_item.dart';
import '../../preferences/widget/preference_item.dart';
import 'volume_slider.dart';

class ReminderContainer extends StatefulWidget {
  const ReminderContainer({super.key});

  @override
  State<ReminderContainer> createState() => _ReminderContainerState();
}

class _ReminderContainerState extends State<ReminderContainer> {
  bool isReminderEnabled = true;
  bool isVibrationEnabled = false;
  double volumeLevel = 0.7;
  String reminderTime = '09:00 AM';
  String selectedRingtone = 'Lollipop';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 10) ,
        decoration: BoxDecoration(
          color: AppColors.blueGrayBackground2,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        ),
        child: Column(
          children: [
            BuildSwitchItem(
              title: 'Reminder',
              value: isReminderEnabled,
              onChanged: (value) {
                setState(() => isReminderEnabled = value);
              },
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: AppColors.grayColor.withOpacity(0.2),
              thickness: 1,
            ),
            PreferenceItem(
              title: 'Reminder Time',
              value: reminderTime,
              onTap: _showCustomTimePicker,
            ),
            PreferenceItem(
              title: 'Ringtone',
              value: selectedRingtone,

              onTap:
                  () => _showRingtonePicker(
                    context: context,
                    currentValue: selectedRingtone,
                    onConfirm: (newValue) {
                      setState(() => selectedRingtone = newValue);
                    },
                  ),
            ),
            VolumeSlider(
              value: volumeLevel,
              onChanged: (value) => setState(() => volumeLevel = value),
            ),
            BuildSwitchItem(
              title: 'Vibration',
              value: isVibrationEnabled,
              onChanged: (value) {
                setState(() => isVibrationEnabled = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomTimePicker() async {
    final TimeOfDay? pickedTime = await showCustomTimePicker(context: context);

    if (pickedTime != null) {
      setState(() {
        reminderTime = pickedTime.format(context);
      });
    }
  }

  void _showRingtonePicker({
    required BuildContext context,
    required String currentValue,
    required Function(String) onConfirm,
  }) {
    final ringtones = [
      'Lollipop',
      'Bells',
      'Chimes',
      'Classic',
      'Digital',
      'Gentle',
      'Harmonics',
      'Notification',
      'Radar',
      'Ringtone',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => CustomPickerBottomSheet(
            title: "Select Ringtone",
            items: ringtones,
            initialValue: currentValue,
            onConfirm: onConfirm,
          ),
    );
  }
}
