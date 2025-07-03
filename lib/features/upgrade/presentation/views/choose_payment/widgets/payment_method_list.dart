 import 'package:flutter/material.dart';

import '../../../../../payment_methods/data/models/payment_method_model.dart';
import 'custom_payment_method_tile.dart';

final List<PaymentMethod> availableMethods = [
  PaymentMethod(
    id: 'paypal',
    name: 'PayPal',
    subtitle: 'mohamed.gomaa@gmail.com',
    icon: Icons.payment,
    isLinked: true,
    iconColor: const Color(0xFF0070BA),
  ),
  PaymentMethod(
    id: 'google_pay',
    name: 'Google Pay',
    subtitle: 'mohamed.gomaa@gmail.com',
    icon: Icons.g_mobiledata,
    isLinked: true,
    iconColor: const Color(0xFF4285F4),
  ),
  PaymentMethod(
    id: 'apple_pay',
    name: 'Apple Pay',
    subtitle: 'mohamed.gomaa@gmail.com',
    icon: Icons.apple,
    isLinked: true,
    iconColor: Colors.white,
  ),
  PaymentMethod(
    id: 'mastercard',
    name: 'Mastercard',
    subtitle: '•••• •••• •••• 4679',
    icon: Icons.credit_card,
    isLinked: true,
    iconColor: const Color(0xFFEB001B),
  ),
  PaymentMethod(
    id: 'visa',
    name: 'Visa',
    subtitle: '•••• •••• •••• 5567',
    icon: Icons.credit_card,
    isLinked: true,
    iconColor: const Color(0xFF1A1F71),
  ),
  PaymentMethod(
    id: 'amex',
    name: 'American Express',
    subtitle: '•••• •••• •••• 8456',
    icon: Icons.credit_card,
    isLinked: true,
    iconColor: const Color(0xFF006FCF),
  ),
];

class PaymentMethodList extends StatelessWidget {
  final String? selectedMethodId;
  final Function(String) onMethodSelected;

  const PaymentMethodList({
    super.key,
    required this.selectedMethodId,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: availableMethods.map((method) {
        return CustomPaymentMethodTile(
          paymentMethod: method,
          isSelected: selectedMethodId == method.id,
          showCheckMark: true,
          onTap: () => onMethodSelected(method.id),
        );
      }).toList(),
    );
  }
}
