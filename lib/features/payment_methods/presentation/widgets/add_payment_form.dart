import 'package:az_health_care/features/payment_methods/presentation/widgets/payment_icons_row.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'card_number_formatter.dart';
import 'expiry_date_dropdown.dart';

class AddPaymentForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController holderNameController;
  final TextEditingController cvvController;
  final String selectedMonth;
  final String selectedYear;
  final Function(String, String) onDateChanged;
  final GlobalKey<FormState> formKey;

  const AddPaymentForm({
    super.key,
    required this.cardNumberController,
    required this.holderNameController,
    required this.cvvController,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onDateChanged,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (i) => (i + 1).toString().padLeft(2, '0'));
    final currentYear = DateTime.now().year % 100;
    final years = List.generate(10, (i) => (currentYear + i).toString());

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Card Number',
              style: AppTextStyles.bold16.copyWith(
                color: AppColors.white60Color,
              ),
            ),
            SizedBox(height: 5),
            CustomTextFormField(
              // label: 'Card Number',
              hintText: "Enter Card Number",
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              validation: (value) {
                if (value == null || value.replaceAll(' ', '').length != 16) {
                  return 'Card number must be 16 digits';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberFormatter(),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Account Holder Name',
              style: AppTextStyles.bold16.copyWith(
                color: AppColors.white60Color,
              ),
            ),
            SizedBox(height: 5),
            CustomTextFormField(
              hintText: "Enter Account Holder Name",
              controller: holderNameController,
              keyboardType: TextInputType.name,
              validation: (value) {
                if (value == null || value.trim().length < 3) {
                  return 'Name must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ExpiryDateDropdown(
                    selectedMonth: selectedMonth,
                    selectedYear: selectedYear,
                    months: months,
                    years: years,
                    onChanged: onDateChanged,
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CVV',
                        style: AppTextStyles.bold16.copyWith(
                          color: AppColors.white60Color,
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: "Enter CVV",
                        controller: cvvController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        validation: (value) {
                          if (value == null || value.length < 3) {
                            return 'CVV must be at least 3 digits';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Supported Payments:',
              style: AppTextStyles.bold16.copyWith(
                color: AppColors.white60Color,
              ),
            ),
            const SizedBox(height: 16),
            const PaymentIconsRow(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
