import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class WaterTrackerHome extends StatefulWidget {
  const WaterTrackerHome({super.key});

  @override
  _WaterTrackerHomeState createState() => _WaterTrackerHomeState();
}

class _WaterTrackerHomeState extends State<WaterTrackerHome>
    with TickerProviderStateMixin {
  int currentWaterAmount = 100;
  int dailyGoal = 20000;
  int glassesCount = 1;
  int selectedGlassSize = 500;
  int selectedReminderMinutes = 15;
  Timer? reminderTimer;
  late AnimationController _progressController;
  late AnimationController _buttonController;

  List<GlassOption> glassOptions = [
    GlassOption(size: 500, icon: '🧴', color: AppColors.primaryGreenColor),
    GlassOption(size: 350, icon: '🥤', color: AppColors.primaryBlueColor),
    GlassOption(size: 250, icon: '🥛', color: Color(0xFF03A9F4)),
    GlassOption(size: 150, icon: '☕', color: Color(0xFF607D8B)),
  ];

  List<int> reminderIntervals = [15, 30, 60, 120];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _progressController.forward();
    _startReminderTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _buttonController.dispose();
    reminderTimer?.cancel();
    super.dispose();
  }

  void _startReminderTimer() {
    reminderTimer?.cancel();
    reminderTimer = Timer.periodic(Duration(minutes: selectedReminderMinutes), (
      timer,
    ) {
      _showReminderNotification();
    });
  }

  void _showReminderNotification() {
    if (mounted) {
      ToastHelper.showToast2(
        context: context,
        msg: 'Time to drink some water 💙',
        state: ToastStates.SUCCESS,
      );
    }
  }

  void _selectGlassSize(int size) {
    setState(() {
      selectedGlassSize = size;
    });
  }

  void _drinkWater() {
    _buttonController.forward().then((_) {
      _buttonController.reverse();
    });

    setState(() {
      currentWaterAmount += selectedGlassSize;
      glassesCount = (currentWaterAmount / selectedGlassSize).ceil();
    });

    _progressController.reset();
    _progressController.forward();

    List<String> encouragingMessages = [
      'Well done! 👏',
      'Keep going! 💪',
      'Awesome! 🌟',
      'Great job! ✨',
    ];
    ToastHelper.showToast2(
      context: context,
      msg:
          encouragingMessages[math.Random().nextInt(
            encouragingMessages.length,
          )],
      state: ToastStates.SUCCESS,
    );
  }

  void _selectReminderInterval(int minutes) {
    setState(() {
      selectedReminderMinutes = minutes;
    });
    _startReminderTimer();
  }

  double get progressPercentage {
    if (currentWaterAmount >= dailyGoal) return 1.0;
    return currentWaterAmount / dailyGoal;
  }

  bool get hasReachedGoal => currentWaterAmount >= dailyGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Water Tracker',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Text('💧', style: TextStyle(fontSize: 20)),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TodayProgressCard(
              currentAmount: currentWaterAmount,
              dailyGoal: dailyGoal,
              glassesCount: glassesCount,
              progressPercentage: progressPercentage,
              controller: _progressController,
            ),
            SizedBox(height: 20),
            GlassSizeSelector(
              glassOptions: glassOptions,
              selectedSize: selectedGlassSize,
              onSizeSelected: _selectGlassSize,
            ),
            SizedBox(height: 20),
            DrinkWaterButton(
              selectedGlassSize: selectedGlassSize,
              onPressed: _drinkWater,
              controller: _buttonController,
            ),
            SizedBox(height: 20),
            ReminderIntervalSelector(
              intervals: reminderIntervals,
              selectedInterval: selectedReminderMinutes,
              onIntervalSelected: _selectReminderInterval,
            ),
            SizedBox(height: 20),
            if (hasReachedGoal) CongratulationsCard(),
            if (hasReachedGoal) SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GlassOption {
  final int size;
  final String icon;
  final Color color;

  GlassOption({required this.size, required this.icon, required this.color});
}

class TodayProgressCard extends StatelessWidget {
  final int currentAmount;
  final int dailyGoal;
  final int glassesCount;
  final double progressPercentage;
  final AnimationController controller;

  const TodayProgressCard({
    super.key,
    required this.currentAmount,
    required this.dailyGoal,
    required this.glassesCount,
    required this.progressPercentage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Today's Progress",
            style: TextStyle(
              color: AppColors.primaryBlueColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: progressPercentage * controller.value,

                      strokeWidth: 14,
                      backgroundColor: Colors.grey.withValues(alpha: 0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressPercentage >= 1.0
                            ? AppColors.primaryGreenColor
                            : AppColors.primaryGreenColor,
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Text(
                    '${currentAmount}ml',
                    style: TextStyle(
                      color: AppColors.primaryBlueColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'of ${dailyGoal}ml',
                    style: TextStyle(
                      color: AppColors.white70Color,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${(progressPercentage * 100).toInt()}%',
                    style: TextStyle(
                      color: AppColors.primaryGreenColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Glasses: ',
                style: TextStyle(
                  color: AppColors.primaryBlueColor,
                  fontSize: 16,
                ),
              ),
              Text(
                '$glassesCount',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Text('🥤', style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

class GlassSizeSelector extends StatelessWidget {
  final List<GlassOption> glassOptions;
  final int selectedSize;
  final Function(int) onSizeSelected;

  const GlassSizeSelector({
    super.key,
    required this.glassOptions,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Select Glass Size',
            style: TextStyle(
              color: AppColors.primaryBlueColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                glassOptions.map((option) {
                  bool isSelected = option.size == selectedSize;
                  return GestureDetector(
                    onTap: () => onSizeSelected(option.size),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? option.color
                                : AppColors.transparentColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? option.color : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(option.icon, style: TextStyle(fontSize: 30)),
                          SizedBox(height: 8),
                          Text(
                            '${option.size}ml',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 14,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class DrinkWaterButton extends StatelessWidget {
  final int selectedGlassSize;
  final VoidCallback onPressed;
  final AnimationController controller;

  const DrinkWaterButton({
    super.key,
    required this.selectedGlassSize,
    required this.onPressed,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 - (controller.value * 0.1),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreenColor,
                foregroundColor: AppColors.whiteColor,

                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Drink Water (${selectedGlassSize}ml)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Text('💧', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReminderIntervalSelector extends StatelessWidget {
  final List<int> intervals;
  final int selectedInterval;
  final Function(int) onIntervalSelected;

  const ReminderIntervalSelector({
    super.key,
    required this.intervals,
    required this.selectedInterval,
    required this.onIntervalSelected,
  });

  String _getIntervalText(int minutes) {
    if (minutes < 60) {
      return 'min $minutes';
    } else {
      int hours = minutes ~/ 60;
      return 'hour${hours > 1 ? 's' : ''} $hours';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reminder Intervals',
                style: TextStyle(
                  color: AppColors.primaryBlueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Text('🔔', style: TextStyle(fontSize: 18)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                intervals.map((interval) {
                  bool isSelected = interval == selectedInterval;
                  return GestureDetector(
                    onTap: () => onIntervalSelected(interval),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primaryGreenColor
                                : AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.primaryGreenColor
                                  : Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _getIntervalText(interval),
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class CongratulationsCard extends StatelessWidget {
  const CongratulationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.buttonColor, AppColors.buttonColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text('🎉', style: TextStyle(fontSize: 40)),
          SizedBox(height: 12),
          Text(
            "Congratulations! You've reached your daily goal",
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
