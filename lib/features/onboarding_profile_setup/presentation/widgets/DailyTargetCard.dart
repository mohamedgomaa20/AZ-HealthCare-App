import 'package:flutter/material.dart';

class DailyTargetCard extends StatelessWidget {
  final int stepsTarget;
  final int caloriesTarget;
  final int caloriesConsumed;

  const DailyTargetCard({
    super.key,
    required this.stepsTarget,
    required this.caloriesTarget,
    required this.caloriesConsumed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Daily Targets",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "Steps: $stepsTarget",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                "Calories to gain: ${caloriesTarget.toStringAsFixed(0)}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              if (caloriesConsumed > caloriesTarget) ...[
                const SizedBox(height: 8),
                Text(
                  "You exceeded your daily target by ${(caloriesConsumed - caloriesTarget).toStringAsFixed(0)} cal. You need to burn this much to return to your target.",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.redAccent),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
