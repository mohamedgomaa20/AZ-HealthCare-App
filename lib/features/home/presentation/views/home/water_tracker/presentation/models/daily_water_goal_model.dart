class DailyWaterGoalModel {
  final String date;
  final int targetAmount;
  final int achievedAmount;

  DailyWaterGoalModel({
    required this.date,
    required this.targetAmount,
    required this.achievedAmount,
  });

  double get progressPercent =>
      targetAmount == 0 ? 0 : achievedAmount / targetAmount;

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'targetAmount': targetAmount,
      'achievedAmount': achievedAmount,
    };
  }
  DailyWaterGoalModel copyWith({
    String? date,
    int? targetAmount,
    int? achievedAmount,
  }) {
    return DailyWaterGoalModel(
      date: date ?? this.date,
      targetAmount: targetAmount ?? this.targetAmount,
      achievedAmount: achievedAmount ?? this.achievedAmount,
    );
  }

  factory DailyWaterGoalModel.fromMap(Map<String, dynamic> map) {
    return DailyWaterGoalModel(
      date: map['date'],
      targetAmount: map['targetAmount'],
      achievedAmount: map['achievedAmount'],
    );
  }
}
