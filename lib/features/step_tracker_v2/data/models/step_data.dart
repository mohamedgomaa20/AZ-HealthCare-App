class StepData {
  final String id;
  final String userId;
  final String date;
  final int steps;
  final int caloriesBurned;
  final double distanceKm;
  final int activeMinutes;
  final DateTime lastUpdated;


  StepData({
    required this.id,
    required this.userId,
    required this.date,
    required this.steps,
    required this.caloriesBurned,
    required this.distanceKm,
    required this.activeMinutes,
    required this.lastUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'date': date,
      'steps': steps,
      'caloriesBurned': caloriesBurned,
      'distanceKm': distanceKm,
      'activeMinutes': activeMinutes,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory StepData.fromMap(Map<String, dynamic> map) {
    return StepData(
      id: map['id'],
      userId: map['userId'],
      date: map['date'],
      steps: map['steps'],
      caloriesBurned: map['caloriesBurned'],
      distanceKm: map['distanceKm'].toDouble(),
      activeMinutes: map['activeMinutes'],
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
    );
  }

  StepData copyWith({
    String? id,
    String? userId,
    String? date,
    int? steps,
    int? caloriesBurned,
    double? distanceKm,
    int? activeMinutes,
    DateTime? lastUpdated,
  }) {
    return StepData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      distanceKm: distanceKm ?? this.distanceKm,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
