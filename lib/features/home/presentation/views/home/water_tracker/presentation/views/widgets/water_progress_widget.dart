import 'package:flutter/material.dart';

import '../../models/daily_water_goal_model.dart';

class WaterProgressWidget extends StatelessWidget {
  final DailyWaterGoalModel goal;
  final Animation<double> _progressAnimation;

  const WaterProgressWidget({
    super.key,
    required this.goal,
    required Animation<double> progressAnimation,
  })  : _progressAnimation = progressAnimation;

  @override
  Widget build(BuildContext context) {
    print('Updated goal date: ${goal.date}');

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF00D4FF).withOpacity(0.1),
                const Color(0xFF0099CC).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00D4FF).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 8,
                        ),
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: _progressAnimation.value,
                            strokeWidth: 8,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF00D4FF),
                            ),
                          ),
                        );
                      },
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          size: 32,
                          color: Color(0xFF00D4FF),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${goal.achievedAmount}ml',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'of ${goal.targetAmount}ml',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    'Progress',
                    '${((goal.achievedAmount / goal.targetAmount) * 100).toInt()}%',
                    Icons.trending_up,
                  ),
                  _buildStatItem(
                    'Remaining',
                    '${(goal.targetAmount - goal.achievedAmount).clamp(0, goal.targetAmount)}ml',
                    Icons.schedule,
                  ),
                  _buildStatItem(
                    'Glasses',
                    '${goal.achievedAmount ~/ 250}',
                    Icons.local_drink,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF00D4FF), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}