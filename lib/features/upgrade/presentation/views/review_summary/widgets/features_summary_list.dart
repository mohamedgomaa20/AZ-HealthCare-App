import 'package:flutter/material.dart';

class FeaturesSummaryList extends StatelessWidget {
  const FeaturesSummaryList({super.key});

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
      children:
          features
              .map(
                (feature) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Color(0xFF2ed573),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check, color: Colors.white, size: 12),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
