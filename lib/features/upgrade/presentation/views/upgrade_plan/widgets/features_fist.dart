import 'package:flutter/material.dart';

import 'feature_item.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({super.key});

  final List<String> features = const [
    'Ad-free experience',
    'Advanced monitoring and tracking',
    'Unlimited AI doctor consultations',
    'Advanced data insights',
    'Priority customer support',
    'Early access to new features',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: features.map((feature) => FeatureItem(text: feature)).toList(),
    );
  }
}
