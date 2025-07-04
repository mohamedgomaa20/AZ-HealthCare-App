import 'package:flutter/material.dart';

import 'custom_action_bottom_sheet.dart';

Future<dynamic> showCustomModalBottomSheet({
  required BuildContext context,
  required String title,
  required String confirmText,
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
  required Widget centerWidget,
  bool? isHasButtons,
}) {
  {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return CustomActionBottomSheet(
          title: title,
          centerWidget: centerWidget,
          confirmText: confirmText,
          onCancel: onCancel,
          onConfirm: onConfirm,
          isHasButtons: isHasButtons,
        );
      },
    );
  }
}

/*
blur
   BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(),
            ),
 */
