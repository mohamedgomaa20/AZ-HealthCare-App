import 'package:flutter/material.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/utils/app_colors.dart';


class PreferenceSection extends StatelessWidget {
  final List<Widget> children;

  const PreferenceSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        color: AppColors.blueGrayBackground2,
      ),
      child: Column(children: children),
    );
  }
}
