import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class ExpiryDateDropdown extends StatelessWidget {
  final String selectedMonth;
  final String selectedYear;
  final List<String> months;
  final List<String> years;
  final Function(String, String) onChanged;

  const ExpiryDateDropdown({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.months,
    required this.years,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry Date',
          style: AppTextStyles.bold16.copyWith(color: AppColors.white60Color),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.blueGrayBackground2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: '$selectedMonth/$selectedYear',
              dropdownColor: AppColors.blueGrayBackground2,
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.white60Color,
              ),
              items:
                  months
                      .expand(
                        (month) => years.map((year) {
                          return DropdownMenuItem<String>(
                            value: '$month/$year',
                            child: Text('$month/$year'),
                          );
                        }),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  final parts = value.split('/');
                  onChanged(parts[0], parts[1]);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
