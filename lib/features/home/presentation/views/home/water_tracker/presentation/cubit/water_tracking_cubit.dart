import 'package:flutter_bloc/flutter_bloc.dart';
import 'water_tracking_state.dart';
import '../models/water_intake_entry_model.dart';
import '../models/daily_water_goal_model.dart';
import '../data/local/water_tracking_dao.dart';

class WaterTrackingCubit extends Cubit<WaterTrackingState> {
  final dao = WaterTrackingDao();

  WaterTrackingCubit get(context) => BlocProvider.of(context);

  WaterTrackingCubit() : super(WaterTrackingInitial());

  Future<void> loadData() async {
    emit(WaterTrackingLoading());
    final today = DateTime.now().toIso8601String().split("T").first;
    await dao.initDefaultIntervals();

    final entries = await dao.getEntries(today);
    final goal =
        await dao.getDailyGoal(today) ??
        DailyWaterGoalModel(date: today, targetAmount: 2000, achievedAmount: 0);

    final intervals = await dao.getIntervals();

    emit(
      WaterTrackingLoaded(entries: entries, goal: goal, intervals: intervals),
    );
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

    await dao.insertOrUpdateGoal(
      DailyWaterGoalModel(
        date: date,
        targetAmount: 2000,
        achievedAmount: total,
      ),
    );

    await loadData();
  }

  Future<void> selectInterval(int minute) async {
    await dao.updateIntervalSelection(minute);
    await loadData();
  }

  // Future<void> updateGoal(int newTarget) async {
  //   final currentState = state;
  //   if (currentState is WaterTrackingLoaded) {
  //     final updatedGoal = DailyWaterGoalModel(
  //       date: currentState.goal.date,
  //       targetAmount: newTarget,
  //       achievedAmount: currentState.goal.achievedAmount,
  //     );
  //
  //     emit(
  //       WaterTrackingLoaded(
  //         entries: currentState.entries,
  //         goal: updatedGoal,
  //         intervals: currentState.intervals,
  //       ),
  //     );
  //   }
  // }
  Future<void> updateGoal(int newTarget) async {
    final currentState = state;
    if (currentState is WaterTrackingLoaded) {
      final updatedGoal = DailyWaterGoalModel(
        date: currentState.goal.date,
        targetAmount: newTarget,
        achievedAmount: currentState.goal.achievedAmount,
      );

      await dao.insertOrUpdateGoal(updatedGoal);

      await loadData();
    }
  }
}
