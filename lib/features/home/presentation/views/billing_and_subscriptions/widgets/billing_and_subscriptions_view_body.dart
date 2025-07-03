 import 'package:az_health_care/features/home/presentation/views/billing_and_subscriptions/widgets/subscription_info_card.dart';
 import 'package:az_health_care/features/upgrade/presentation/views/upgrade_plan/widgets/subscription_plan_card.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';

class BillingAndSubscriptionsViewBody extends StatelessWidget {
  const BillingAndSubscriptionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(title: 'Billing & Subscriptions'),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SubscriptionPlanCard(isMonthly: false, showTrailWidget: true),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SubscriptionInfoCard(),
        ],
      ),
    );
  }
}

