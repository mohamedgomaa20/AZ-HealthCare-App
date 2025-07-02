import 'package:az_health_care/features/upgrade/presentation/views/review_summary/widgets/review_summary_view_body.dart';
import 'package:flutter/material.dart';

class ReviewSummaryView extends StatelessWidget {
  final String selectedPaymentMethod;
  static const routeName = 'reviewSummaryView';

  const ReviewSummaryView({super.key, required this.selectedPaymentMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReviewSummaryViewBody(
          selectedPaymentMethod: selectedPaymentMethod,
        ),
      ),
    );
  }
}
