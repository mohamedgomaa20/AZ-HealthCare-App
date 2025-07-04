import '../models/daily_water_goal_model.dart';
import '../models/interval_model.dart';
import '../models/water_intake_entry_model.dart';

abstract class WaterTrackingState {}

class WaterTrackingInitial extends WaterTrackingState {}
class WaterTrackingUpdated extends WaterTrackingState {}
class WaterTrackingChangeGoal extends WaterTrackingState {}

class WaterTrackingLoading extends WaterTrackingState {}
class WaterTrackingLoaded extends WaterTrackingState {
  final List<WaterIntakeEntryModel> entries;
  final DailyWaterGoalModel goal;
  final List<IntervalModel> intervals;

  WaterTrackingLoaded({
    required this.entries,
    required this.goal,
    required this.intervals,
  });
}

class WaterTrackingError extends WaterTrackingState {
  final String message;
  WaterTrackingError(this.message);
}
