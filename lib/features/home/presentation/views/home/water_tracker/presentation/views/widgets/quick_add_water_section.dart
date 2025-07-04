
import 'package:flutter/material.dart';
import 'quick_add_water_button.dart';
class QuickAddWaterSection extends StatelessWidget {
  final AnimationController rippleController;

  const QuickAddWaterSection({
    super.key,
    required this.rippleController,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> quickAmounts = [
      {'amount': 250, 'label': 'Glass', 'icon': Icons.local_drink},
      {'amount': 500, 'label': 'Bottle', 'icon': Icons.sports_bar},
      {'amount': 750, 'label': 'Large', 'icon': Icons.local_bar},
      {'amount': 1000, 'label': 'Jug', 'icon': Icons.coffee},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Add',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: quickAmounts.length,
            itemBuilder: (context, index) {
              final item = quickAmounts[index];
              return QuickAddWaterButton(
                amount: item['amount'] as int,
                label: item['label'] as String,
                icon: item['icon'] as IconData,
                rippleController: rippleController,
              );
            },
          ),
        ],
      ),
    );
  }
}