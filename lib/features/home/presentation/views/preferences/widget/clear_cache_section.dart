import 'package:az_health_care/features/home/presentation/views/preferences/widget/preference_item.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/widgets/custom_confirmation_dialog.dart';

class ClearCacheSection extends StatelessWidget {
  final String cacheSize;
  final VoidCallback onClear;

  const ClearCacheSection({
    super.key,
    required this.cacheSize,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItem(
      title: "Clear Cache",
      value: cacheSize,
      onTap:
          () => showCustomConfirmationDialog(
        context: context,
        title: 'Clear Cache',
        content: 'Clear $cacheSize of cached data?',
        confirmText: 'Clear',
        onConfirm: onClear,
      ),
    );
  }
}
