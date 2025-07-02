import 'package:az_health_care/features/upgrade/presentation/views/review_summary/widgets/selected_payment_card.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/widgets/custom_loading_dialog.dart';

import '../../../../../home/presentation/views/profile/widgets/primary_bottom_button.dart';
import '../../choose_payment/widgets/payment_app_bar.dart';
import '../../congratulations/congratulations_view.dart';
import '../../upgrade_plan/widgets/subscription_plan_card.dart';

class ReviewSummaryViewBody extends StatelessWidget {
  final String selectedPaymentMethod;

  const ReviewSummaryViewBody({super.key, required this.selectedPaymentMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(title: 'Review Summary'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SubscriptionPlanCard(isMonthly: false),
                        const SizedBox(height: 20),
                        SelectedPaymentCard(
                          paymentMethod: selectedPaymentMethod,
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
          text: 'Confirm Payment - \$99.99',
          onTap: () {
            // Handle payment confirmation
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => CustomLoadingDialog(
                    message: 'Processing payment...',
                    delay: Duration(seconds: 1),
                    onComplete: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CongratulationsView(),
                        ),
                      );
                    },
                  ),
            );
          },
        ),
      ],
    );
  }
}
