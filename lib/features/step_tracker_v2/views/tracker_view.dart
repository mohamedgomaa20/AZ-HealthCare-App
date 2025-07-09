import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/step_tracker_cubit/step_tracker_cubit.dart';
import '../manager/step_tracker_cubit/step_tracker_state.dart';
import '../widgets/step_summary_stats.dart';
import '../widgets/today_progress_card.dart';
import '../widgets/weekly_step_chart.dart';
import 'history_view.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TrackerScreenView();
  }
}

class TrackerScreenView extends StatelessWidget {
  const TrackerScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Step Tracker',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<StepTrackerCubit>().refreshData();
            },
          ),
        ],
      ),
      body: BlocBuilder<StepTrackerCubit, StepTrackerState>(
        builder: (context, state) {
          if (state is StepTrackerLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
              ),
            );
          }

          if (state is StepTrackerError) {
             print("=====================================");
            print(state.message);
             print("=====================================");
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StepTrackerCubit>().initializeStepTracker();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is StepTrackerLoaded) {
            int goal = BlocProvider.of<StepTrackerCubit>(context).dailyGoal ?? 1000;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodayProgressCardWater(
                    todayData: state.todayData,
                    dailyGoal: goal,
                  ),
                  const SizedBox(height: 20),

                  StepSummaryStats(
                    todayData: state.todayData,
                    dailyGoal: goal,
                  ),
                  const SizedBox(height: 20),
                  WeeklyStepChart(weeklyData: state.weeklyData),

                  const SizedBox(height: 20),

                  _buildActionButtons(context),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                },
                icon: const Icon(Icons.history),
                label: const Text('History'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF6366F1),
                  side: const BorderSide(color: Color(0xFF6366F1)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _showGoalDialog(context);
            },
            icon: const Icon(Icons.flag),
            label: const Text('Set Daily Goal'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              side: const BorderSide(color: Color(0xFF10B981)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showGoalDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.blueGrayBackground2,
          title: const Text('Set Daily Goal'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Steps',
              hintText: 'Enter your daily step goal',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final input = controller.text;
                 final goal = int.tryParse(input);

                if (goal != null && goal > 0) {
                  context.read<StepTrackerCubit>().updateDailyGoal(goal);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
