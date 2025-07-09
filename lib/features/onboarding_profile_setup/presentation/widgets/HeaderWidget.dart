import 'package:flutter/material.dart';

class HeaderWidgetSensor extends StatelessWidget {
  const HeaderWidgetSensor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Sensor Data Upload',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 12),

        Text(
          'Optionally upload your sensor data file to import readings',
          style: TextStyle(color: Colors.grey[400], fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
