import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/interval_model.dart';
import 'water_tracking_state.dart';
import '../models/water_intake_entry_model.dart';
import '../models/daily_water_goal_model.dart';
import '../data/local/water_tracking_dao.dart';

class WaterTrackingCubit extends Cubit<WaterTrackingState> {
  final dao = WaterTrackingDao();

   List<WaterIntakeEntryModel> entries = [];
  DailyWaterGoalModel? goal;
  List<IntervalModel> intervals = [];
  static WaterTrackingCubit get(context) => BlocProvider.of(context);

  WaterTrackingCubit() : super(WaterTrackingInitial());

  Future<void> loadData() async {
    emit(WaterTrackingLoading());

    final today = DateTime.now().toIso8601String().split("T").first;
    await dao.initDefaultIntervals();

    entries = await dao.getEntries(today);
    goal = await dao.getDailyGoal(today) ??
        DailyWaterGoalModel(date: today, targetAmount: 1000, achievedAmount: 0);

    intervals = await dao.getIntervals();

    emit(WaterTrackingLoaded(
      entries: entries,
      goal: goal!,
      intervals: intervals,
    ));
  }

  Future<void> addWater(int amount, String glassType) async {
    final now = DateTime.now();
    final date = now.toIso8601String().split("T").first;

    await dao.insertWaterEntry(
      WaterIntakeEntryModel(
        date: date,
        timestamp: now.millisecondsSinceEpoch,
        amount: amount,
        glassType: glassType,
      ),
    );

    final total = await dao.getTotalIntake(date);
    final existingGoal = await dao.getDailyGoal(date);

    goal = DailyWaterGoalModel(
      date: date,
      targetAmount: existingGoal?.targetAmount ?? 2000,
      achievedAmount: total,
    );

    await dao.insertOrUpdateGoal(goal!);
    await loadData();
  }

  Future<void> selectInterval(int minute) async {
    await dao.updateIntervalSelection(minute);
    await loadData();
  }

  Future<void> updateGoal(int newTarget) async {
    final today = DateTime.now().toIso8601String().split("T").first;

    goal = goal?.copyWith(targetAmount: newTarget) ??
        DailyWaterGoalModel(
          date: today,
          targetAmount: newTarget,
          achievedAmount: 0,
        );

    await dao.insertOrUpdateGoal(goal!);

    emit(WaterTrackingLoaded(
      entries: entries,
      goal: goal!,
      intervals: intervals,
    ));
  }
}
