import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';

import '../choose_payment_view.dart';

class PaymentMethodList extends StatelessWidget {
  final String? selectedMethod;
  final Function(String) onMethodSelected;

  const PaymentMethodList({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaymentMethodItem(
          icon: 'assets/paypal_icon.png',
          title: 'PayPal',
          subtitle: 'mohamed.gomaa@gmail.com',
          isSelected: selectedMethod == 'PayPal',
          onTap: () => onMethodSelected('PayPal'),
        ),

        PaymentMethodItem(
          icon: 'assets/google_pay_icon.png',
          title: 'Google Pay',
          subtitle: 'mohamed.gomaa@gmail.com',
          isSelected: selectedMethod == 'Google Pay',
          onTap: () => onMethodSelected('Google Pay'),
        ),

        PaymentMethodItem(
          icon: 'assets/apple_pay_icon.png',
          title: 'Apple Pay',
          subtitle: 'mohamed.gomaa@gmail.com',
          isSelected: selectedMethod == 'Apple Pay',
          onTap: () => onMethodSelected('Apple Pay'),
        ),

        // Credit Cards
        PaymentMethodItem(
          icon: 'assets/mastercard_icon.png',
          title: 'Mastercard',
          subtitle: '**** **** **** 4679',
          isSelected: selectedMethod == 'Mastercard',
          onTap: () => onMethodSelected('Mastercard'),
        ),

        PaymentMethodItem(
          icon: 'assets/visa_icon.png',
          title: 'Visa',
          subtitle: '**** **** **** 5567',
          isSelected: selectedMethod == 'Visa',
          onTap: () => onMethodSelected('Visa'),
        ),

        PaymentMethodItem(
          icon: 'assets/amex_icon.png',
          title: 'American Express',
          subtitle: '**** **** **** 8456',
          isSelected: selectedMethod == 'American Express',
          onTap: () => onMethodSelected('American Express'),
        ),
      ],
    );
  }
}
