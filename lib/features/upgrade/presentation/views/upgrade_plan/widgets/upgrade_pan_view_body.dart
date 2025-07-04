import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:az_health_care/features/upgrade/presentation/views/upgrade_plan/widgets/plan_toggle_switch.dart';
import 'package:az_health_care/features/upgrade/presentation/views/upgrade_plan/widgets/subscription_plan_card.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/primary_bottom_button.dart';
import '../../choose_payment/choose_payment_view.dart';

class UpgradePanViewBody extends StatefulWidget {
  const UpgradePanViewBody({super.key});

  @override
  State<UpgradePanViewBody> createState() => _UpgradePanViewBodyState();
}

class _UpgradePanViewBodyState extends State<UpgradePanViewBody> {
  bool isMonthly = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: 'Upgrade Plan',),
          SizedBox(height: 15,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),

                  PlanToggleSwitch(
                    isMonthly: isMonthly,
                    onToggle: (value) {
                      setState(() {
                        isMonthly = value;
                      });
                    },
                  ),

                  SizedBox(height: 40),

                  SubscriptionPlanCard(isMonthly: isMonthly),
                ],
              ),
            ),
          ),
          PrimaryBottomButton(
            text: 'Continue - \$${isMonthly ? '9' : '99'}.99',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChoosePaymentView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
