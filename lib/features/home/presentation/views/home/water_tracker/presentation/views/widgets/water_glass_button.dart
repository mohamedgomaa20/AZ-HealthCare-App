import 'package:flutter/material.dart';

class WaterGlassButton extends StatelessWidget {
  final int amount;
  final String label;
  final VoidCallback onPressed;

  const WaterGlassButton({
    super.key,
    required this.amount,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: label,
          onPressed: onPressed,
          child: Text('$amount\nml', textAlign: TextAlign.center),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
