import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/cupertino.dart';

 import '../../../../../../core/widgets/custom_confirmation_dialog.dart';

class ResetAllProgressSection extends StatelessWidget {
  const ResetAllProgressSection({super.key, required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: 'Reset Progress',
      value: "",
      onTap: () {
        showCustomConfirmationDialog(
          context: context,
          title: 'Reset Progress',
          content:
              'Are you sure you want to reset all progress? This action cannot be undone.',
          confirmText: 'Reset',
          onConfirm: onReset,
        );
      },
    );
  }
}
