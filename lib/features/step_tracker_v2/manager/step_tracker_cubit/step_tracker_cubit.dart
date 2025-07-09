import 'package:az_health_care/features/step_tracker_v2/manager/step_tracker_cubit/step_tracker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../../../core/services/cache_helper.dart';
import '../../data/database/database_helper.dart';

import '../../data/models/step_data.dart';

class StepTrackerCubit extends Cubit<StepTrackerState> {
  StepTrackerCubit() : super(StepTrackerInitial());

  StreamSubscription<StepCount>? _stepCountSubscription;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusSubscription;

  Future<void> initializeStepTracker() async {
    emit(StepTrackerLoading());

    try {
      final hasPermission = await _requestPermissions();

      if (!hasPermission) {
        emit(const StepTrackerError('Permission denied'));
        return;
      }

      await _loadTodayData();
      await _loadWeeklyData();

      await _startStepCounting();

      emit(
        StepTrackerLoaded(
          todayData: await _getTodayData(),
          weeklyData: await _getWeeklyData(),
          hasPermission: true,
        ),
      );
    } catch (e) {
      emit(StepTrackerError('Failed to initialize: $e'));
    }
  }

  int _dailyGoal = 10000;
  int _caloriesTarget = 2000;

  int get caloriesTarget =>
      CacheHelper.getData(key: 'calculatedCaloriesTarget') ?? _caloriesTarget;

  int get dailyGoal => CacheHelper.getData(key: 'dailyGoal') ?? _dailyGoal;

  void updateDailyGoal(int newGoal) async {
    CacheHelper.saveData(key: 'dailyGoal', value: newGoal);
    _dailyGoal = CacheHelper.getData(key: 'dailyGoal');
    if (state is StepTrackerLoaded) {
      final current = state as StepTrackerLoaded;
      emit(current.copyWith(dailyGoal: _dailyGoal));
    }
  }



  Future<bool> _requestPermissions() async {
    final status = await Permission.activityRecognition.status;

    if (status.isGranted) {
      return true;
    } else {
      final result = await Permission.activityRecognition.request();

      if (result.isGranted) {
        return true;
      } else if (result.isPermanentlyDenied) {
        openAppSettings();
      }

      return false;
    }
  }

  Future<void> _startStepCounting() async {
    try {
      _stepCountSubscription = Pedometer.stepCountStream.listen(
        (StepCount event) {
          _updateStepCount(event.steps);
        },
        onError: (error) {
          emit(StepTrackerError('Step counting error: $error'));
        },
      );

      _pedestrianStatusSubscription = Pedometer.pedestrianStatusStream.listen(
        (PedestrianStatus event) {},
        onError: (error) {},
      );
    } catch (e) {
      emit(StepTrackerError('Failed to start step counting: $e'));
    }
  }

  Future<void> _updateStepCount(int steps) async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final existingData = await DatabaseHelper.getStepDataByDate(today);

      final caloriesBurned = (steps * 0.04).round();
      final distance = (steps * 0.0008);
      final activeMinutes = (steps / 100).round();

      if (existingData != null) {
        await DatabaseHelper.updateStepCount(
          today,
          steps,
          caloriesBurned,
          distance,
          activeMinutes,
        );
      } else {
        final newData = StepData(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: 'user1',
          // You can get this from authentication
          date: today,
          steps: steps,
          caloriesBurned: caloriesBurned,
          distanceKm: distance,
          activeMinutes: activeMinutes,
          lastUpdated: DateTime.now(),
        );
        await DatabaseHelper.insertStepData(newData);
      }

      final currentState = state;
      if (currentState is StepTrackerLoaded) {
        final updatedTodayData = await _getTodayData();
        await _loadWeeklyData();
        emit(
          currentState.copyWith(
            todayData: updatedTodayData,
            weeklyData: _weeklyData,
          ),
        );
      }
    } catch (e) {
      print("Error updating step count: $e");
    }
  }

  Future<void> _loadTodayData() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final data = await DatabaseHelper.getStepDataByDate(today);

    if (data == null) {
      // Create today's entry
      final newData = StepData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'user1',
        date: today,
        steps: 0,
        caloriesBurned: 0,
        distanceKm: 0.0,
        activeMinutes: 0,
        lastUpdated: DateTime.now(),
      );
      await DatabaseHelper.insertStepData(newData);
    }
  }

  late List<StepData> _weeklyData;

  Future<void> _loadWeeklyData() async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 6));

    final startDateStr = DateFormat('yyyy-MM-dd').format(startDate);
    final endDateStr = DateFormat('yyyy-MM-dd').format(endDate);

    _weeklyData = await DatabaseHelper.getStepDataRange(
      startDateStr,
      endDateStr,
    );
    print('=== Weekly Data ===');
    for (var data in _weeklyData) {
      print('${data.date}: ${data.steps}');
    }
  }

  Future<StepData?> _getTodayData() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return await DatabaseHelper.getStepDataByDate(today);
  }

  Future<List<StepData>> _getWeeklyData() async {
    return await DatabaseHelper.getLastSevenDays();
  }

  Future<void> refreshData() async {
    await _loadTodayData();
    await _loadWeeklyData();

    if (state is StepTrackerLoaded) {
      final currentState = state as StepTrackerLoaded;
      emit(
        currentState.copyWith(
          todayData: await _getTodayData(),
          weeklyData: await _getWeeklyData(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _stepCountSubscription?.cancel();
    _pedestrianStatusSubscription?.cancel();
    return super.close();
  }
}
