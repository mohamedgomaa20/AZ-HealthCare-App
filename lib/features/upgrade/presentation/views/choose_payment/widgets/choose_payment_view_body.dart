 import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_method_list.dart';
import 'package:flutter/material.dart';

import '../../../../../home/presentation/views/profile/widgets/primary_bottom_button.dart';
import '../../review_summary/review_summary_view.dart';
import '../../review_summary/widgets/review_summary_view_body.dart';

class ChoosePaymentViewBody extends StatefulWidget {
  const ChoosePaymentViewBody({super.key});

  @override
  State<ChoosePaymentViewBody> createState() => _ChoosePaymentViewBodyState();
}

class _ChoosePaymentViewBodyState extends State<ChoosePaymentViewBody> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Choose Payment Methods'),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PaymentMethodList(
                          selectedMethod: selectedPaymentMethod,
                          onMethodSelected: (method) {
                            setState(() {
                              selectedPaymentMethod = method;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        PrimaryBottomButton(
          text: "Continue",
          onTap:
              selectedPaymentMethod != null
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ReviewSummaryView(
                              selectedPaymentMethod: selectedPaymentMethod!,
                            ),
                      ),
                    );
                  }
                  : null,
        ),
      ],
    );
  }
}
