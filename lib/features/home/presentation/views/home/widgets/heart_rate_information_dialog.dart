import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

void showHeartRateInformationDialog({
  required BuildContext context,
  String title = 'Hart Rate Status',
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.backgroundStepColor,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BloodPressureRow(
                label: 'Category',
                sbp: 'SBP',
                dbp: 'DBP',
                isHeader: true,
                textColor: Colors.grey,
              ),
              BloodPressureRow(
                label: 'Normal',
                sbp: '< 120 mmHg',
                dbp: 'And < 80 mmHg',
                textColor: AppColors.greenColor,
              ),
              BloodPressureRow(
                label: 'Hypotension',
                sbp: '< 90 mmHg',
                dbp: '< 60 mmHg',
              ),
              BloodPressureRow(
                label: 'Elevated',
                sbp: '120–129 mmHg',
                dbp: 'And < 80 mmHg',
              ),
              BloodPressureRow(
                label: 'High BP Stage 1',
                sbp: '130–139 mmHg',
                dbp: 'Or 80–89 mmHg',
              ),
              BloodPressureRow(
                label: 'High BP Stage 2',
                sbp: '≥ 140 mmHg',
                dbp: 'Or ≥ 90 mmHg',
              ),
              BloodPressureRow(
                label: 'Hypertensive Crisis',
                sbp: '> 180 mmHg',
                dbp: 'And/or >120 mmHg',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class BloodPressureRow extends StatelessWidget {
  final String label;
  final String sbp;
  final String dbp;
  final bool isHeader;
  final Color textColor;

  const BloodPressureRow({
    super.key,
    required this.label,
    required this.sbp,
    required this.dbp,
    this.isHeader = false,
    this.textColor = AppColors.redLight,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: isHeader ? 16 : 14,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: textColor,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isHeader ? 6 : 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: textStyle)),
          Expanded(child: Text(sbp, style: textStyle)),
          Expanded(child: Text(dbp, style: textStyle)),
        ],
      ),
    );
  }
}
