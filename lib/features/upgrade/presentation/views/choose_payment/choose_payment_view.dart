import 'package:flutter/material.dart';
import 'widgets/choose_payment_view_body.dart';

class ChoosePaymentView extends StatelessWidget {
  const ChoosePaymentView({super.key});

  static const routeName = 'choosePaymentView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ChoosePaymentViewBody()));
  }
}
