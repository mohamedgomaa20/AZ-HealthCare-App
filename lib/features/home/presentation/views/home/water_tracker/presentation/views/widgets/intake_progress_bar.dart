import 'package:flutter/material.dart';

class IntakeProgressBar extends StatelessWidget {
  final int total;
  final int current;

  const IntakeProgressBar({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final percent = current / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's Progress: $current / $total ml"),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: percent.clamp(0.0, 1.0),
          color: Colors.blue,
          backgroundColor: Colors.grey[300],
          minHeight: 10,
        ),
      ],
    );
  }
}
