
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/water_tracking_cubit.dart';

 class QuickAddWaterButton extends StatefulWidget {
  final int amount;
  final String label;
  final IconData icon;
  final AnimationController rippleController;

  const QuickAddWaterButton({
    super.key,
    required this.amount,
    required this.label,
    required this.icon,
    required this.rippleController,
  });

  @override
  State<QuickAddWaterButton> createState() => _QuickAddWaterButtonState();
}

class _QuickAddWaterButtonState extends State<QuickAddWaterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<WaterTrackingCubit>().addWater(widget.amount, widget.label);
        widget.rippleController.forward().then((_) {
          widget.rippleController.reset();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00D4FF).withOpacity(0.1), // تصحيح withValues إلى withOpacity
              const Color(0xFF0099CC).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00D4FF).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 32, color: const Color(0xFF00D4FF)),
            const SizedBox(height: 8),
            Text(
              '${widget.amount}ml',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}