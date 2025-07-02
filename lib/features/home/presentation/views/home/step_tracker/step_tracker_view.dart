
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/bottom_info_row.dart';
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/calories_card.dart';
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/steps_card.dart';
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/today_progress_card.dart';
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/widgets/weekly_progress_card.dart';
import 'package:flutter/material.dart';

class StepsTrackerScreen extends StatelessWidget {
  const StepsTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Steps Tracker',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.directions_walk, color: Colors.blueAccent),
          ],
        ),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TodayProgressCard(),
            SizedBox(height: 12),
            StepsCard(),
            SizedBox(height: 12),
            CaloriesCard(),
            SizedBox(height: 12),
            WeeklyProgressCard(),
            SizedBox(height: 12),
            BottomInfoRow(),
          ],
        ),
      ),
    );
  }
}







