import 'package:equatable/equatable.dart';

import '../../data/models/step_data.dart';

abstract class StepTrackerState extends Equatable {
  const StepTrackerState();

  @override
  List<Object?> get props => [];
}

class StepTrackerInitial extends StepTrackerState {}

class StepTrackerLoading extends StepTrackerState {}

class StepTrackerLoaded extends StepTrackerState {
  final StepData? todayData;
  final List<StepData> weeklyData;
  final int dailyGoal;
  final bool hasPermission;

  const StepTrackerLoaded({
    this.todayData,
    this.weeklyData = const [],
    this.dailyGoal = 10000,
    this.hasPermission = false,
  });

  @override
  List<Object?> get props => [todayData, weeklyData, dailyGoal, hasPermission];

  StepTrackerLoaded copyWith({
    StepData? todayData,
    List<StepData>? weeklyData,
    int? dailyGoal,
    bool? hasPermission,
  }) {
    return StepTrackerLoaded(
      todayData: todayData ?? this.todayData,
      weeklyData: weeklyData ?? this.weeklyData,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      hasPermission: hasPermission ?? this.hasPermission,
    );
  }
}

class StepTrackerError extends StepTrackerState {
  final String message;

  const StepTrackerError(this.message);

  @override
  List<Object> get props => [message];
}