import 'package:az_health_care/features/home/presentation/views/profile/widgets/primary_bottom_button.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/payment_method_model.dart';
import '../../../upgrade/presentation/views/choose_payment/widgets/custom_payment_method_tile.dart';
 import 'add_payment_view.dart';

class PaymentMethodsView extends StatefulWidget {
  const PaymentMethodsView({super.key});

  @override
  State<PaymentMethodsView> createState() => _PaymentMethodsViewState();
}

class _PaymentMethodsViewState extends State<PaymentMethodsView> {
  List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: '1',
      name: 'PayPal',
      subtitle: 'mohamed.gomaa@gmail.com..',
      icon: Icons.payment,
      isLinked: true,
      iconColor: AppColors.paypalColor,
    ),
    PaymentMethod(
      id: '2',
      name: 'Google Pay',
      subtitle: 'mohamed.gomaa@gmail.com..',
      icon: Icons.g_mobiledata,
      isLinked: true,
      iconColor: AppColors.googlePayColor,
    ),
    PaymentMethod(
      id: '3',
      name: 'Apple Pay',
      subtitle: 'mohamed.gomaa@gmail.com..',
      icon: Icons.apple,
      isLinked: true,
      iconColor: AppColors.applePayColor,
    ),
    PaymentMethod(
      id: '4',
      name: 'Mastercard',
      subtitle: '•••• •••• •••• 4679',
      icon: Icons.credit_card,
      isLinked: true,
      iconColor: AppColors.mastercardColor,
    ),
    PaymentMethod(
      id: '5',
      name: 'Visa',
      subtitle: '•••• •••• •••• 5567',
      icon: Icons.credit_card,
      isLinked: true,
      iconColor: AppColors.visaColor,
    ),
  ];

  void _addNewPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => AddPaymentView(
              onPaymentAdded: (PaymentMethod newPayment) {
                setState(() {
                  paymentMethods.add(newPayment);
                });
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Payment Methods"),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return CustomPaymentMethodTile(
                    paymentMethod: paymentMethods[index],
                    showStatus: true,
                  );
                },
              ),
            ),
            PrimaryBottomButton(
              isLeftIcon: true,
              icon: Icons.add,
              text: "Add New Payment",
              onTap: _addNewPayment,
            ),
          ],
        ),
      ),
    );
  }
}
