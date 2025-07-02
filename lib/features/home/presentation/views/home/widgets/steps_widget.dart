import 'dart:math';

import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/home/presentation/views/home/step_tracker/step_tracker_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double progress = 0.50;
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
              SizedBox(height: 10),
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
                        SizedBox(height: 5),
                        Text(
                          "0",
                          style: AppTextStyles.bold20.copyWith(
                            color: AppColors.greenLightColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "/10000",
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
                        builder: (context) => StepsTrackerScreen(),
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
