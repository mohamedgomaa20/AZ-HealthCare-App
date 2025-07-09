import 'dart:math';

import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../step_tracker_v2/manager/step_tracker_cubit/step_tracker_cubit.dart';
import '../../../../../step_tracker_v2/manager/step_tracker_cubit/step_tracker_state.dart';
import '../../../../../step_tracker_v2/views/tracker_view.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepTrackerCubit, StepTrackerState>(
      builder: (context, state) {
        int steps = 0;
        int goal = BlocProvider.of<StepTrackerCubit>(context).dailyGoal ?? 1000;

        if (state is StepTrackerLoaded && state.todayData != null) {
          steps = state.todayData!.steps;
        }

        double progress = (steps / goal).clamp(0.0, 1.0);

        return Container(
          height: 140,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundStepColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("Steps", style: AppTextStyles.bold18),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 90,
                    height: 85,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(100, 90),
                          painter: StepProgressPainter(
                            progress: progress,
                            backgroundColor: AppColors.unselectedColor,
                            progressColor: AppColors.selectedColor,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Today's steps",
                              style: AppTextStyles.regular10.copyWith(
                                color: AppColors.selectedColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "$steps",
                              style: AppTextStyles.bold20.copyWith(
                                color: AppColors.greenLightColor,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "/$goal",
                              style: AppTextStyles.regular10.copyWith(
                                color: AppColors.selectedColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      color: AppColors.whiteColor,
                      size: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TrackerScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundArrowColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StepProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  StepProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    this.strokeWidth = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startAngle = 3 * pi / 4 + .3;
    final sweepAngle = 3 * pi / 2 - .6;

    final bgPaint =
        Paint()
          ..color = backgroundColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final fgPaint =
        Paint()
          ..color = progressColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, bgPaint);

    canvas.drawArc(rect, startAngle, sweepAngle * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
