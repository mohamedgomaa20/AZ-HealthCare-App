import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'build_payment_icon.dart';

class PaymentIconsRow extends StatelessWidget {
  const PaymentIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuildPaymentIcon(color: AppColors.mastercardColor, label: 'MC'),
        const SizedBox(width: 12),
        BuildPaymentIcon(color: AppColors.visaColor, label: 'VISA'),
        const SizedBox(width: 12),
        BuildPaymentIcon(
          color: AppColors.amazonPayColor,
          label: 'amazon',
          textColor: Colors.black,
        ),
        const SizedBox(width: 12),
        BuildPaymentIcon(color: AppColors.amexColor, label: 'AMEX'),
        const SizedBox(width: 12),
        BuildPaymentIcon(color: AppColors.jcbColor, label: 'JCB'),
      ],
    );
  }
}
