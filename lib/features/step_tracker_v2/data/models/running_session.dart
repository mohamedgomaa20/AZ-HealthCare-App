class RunningSession {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final int steps;
  final double distance;
  final double caloriesBurned;
  final Duration duration;
  final bool isActive;

  RunningSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.steps,
    required this.distance,
    required this.caloriesBurned,
    required this.duration,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'steps': steps,
      'distance': distance,
      'caloriesBurned': caloriesBurned,
      'duration': duration.inMilliseconds,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory RunningSession.fromMap(Map<String, dynamic> map) {
    return RunningSession(
      id: map['id'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      steps: map['steps'],
      distance: map['distance'].toDouble(),
      caloriesBurned: map['caloriesBurned'].toDouble(),
      duration: Duration(milliseconds: map['duration']),
      isActive: map['isActive'] == 1,
    );
  }

  RunningSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? steps,
    double? distance,
    double? caloriesBurned,
    Duration? duration,
    bool? isActive,
  }) {
    return RunningSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      steps: steps ?? this.steps,
      distance: distance ?? this.distance,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      duration: duration ?? this.duration,
      isActive: isActive ?? this.isActive,
    );
  }
}
