class WaterIntakeEntryModel {
  final int? id;
  final String date;
  final int timestamp;
  final int amount;
  final String glassType;

  WaterIntakeEntryModel({
    this.id,
    required this.date,
    required this.timestamp,
    required this.amount,
    required this.glassType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'timestamp': timestamp,
      'amount': amount,
      'glassType': glassType,
    };
  }

  factory WaterIntakeEntryModel.fromMap(Map<String, dynamic> map) {
    return WaterIntakeEntryModel(
      id: map['id'],
      date: map['date'],
      timestamp: map['timestamp'],
      amount: map['amount'],
      glassType: map['glassType'],
    );
  }
}
