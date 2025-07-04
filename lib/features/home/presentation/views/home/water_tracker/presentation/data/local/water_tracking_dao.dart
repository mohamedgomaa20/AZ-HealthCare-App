import 'package:sqflite/sqflite.dart';
import 'water_tracking_db.dart';
import '../../models/water_intake_entry_model.dart';
import '../../models/daily_water_goal_model.dart';
import '../../models/interval_model.dart';

class WaterTrackingDao {
  static const String tableWaterIntake = 'water_intake';
  static const String tableDailyGoal = 'daily_goal';
  static const String tableIntervals = 'intervals';

  final db = WaterTrackingDB.instance;

   Future<void> insertWaterEntry(WaterIntakeEntryModel entry) async {
    final database = await db.database;
    await database.insert(tableWaterIntake, entry.toMap());
  }

   Future<List<WaterIntakeEntryModel>> getEntries(String date) async {
    final database = await db.database;
    final result = await database.query(
      tableWaterIntake,
      where: 'date = ?',
      whereArgs: [date],
      orderBy: 'timestamp DESC',
    );
    return result.map((e) => WaterIntakeEntryModel.fromMap(e)).toList();
  }

   Future<void> insertOrUpdateGoal(DailyWaterGoalModel goal) async {
    final database = await db.database;
    await database.insert(
      tableDailyGoal,
      goal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<DailyWaterGoalModel?> getDailyGoal(String date) async {
    final database = await db.database;
    final result = await database.query(
      tableDailyGoal,
      where: 'date = ?',
      whereArgs: [date],
    );

    if (result.isNotEmpty) {
      return DailyWaterGoalModel.fromMap(result.first);
    }
    return null;
  }

   Future<int> getTotalIntake(String date) async {
    final database = await db.database;
    final result = await database.rawQuery(
      'SELECT SUM(amount) as total FROM $tableWaterIntake WHERE date = ?',
      [date],
    );
    return result.first['total'] as int? ?? 0;
  }

   Future<List<IntervalModel>> getIntervals() async {
    final database = await db.database;
    final result = await database.query(tableIntervals);
    return result.map((e) => IntervalModel.fromMap(e)).toList();
  }

   Future<void> updateIntervalSelection(int minute) async {
    final database = await db.database;
    await database.update(tableIntervals, {'selected': 0});
    await database.update(
      tableIntervals,
      {'selected': 1},
      where: 'minute = ?',
      whereArgs: [minute],
    );
  }

   Future<void> initDefaultIntervals() async {
    final database = await db.database;
    final count = Sqflite.firstIntValue(
      await database.rawQuery('SELECT COUNT(*) FROM $tableIntervals'),
    );
    if (count == 0) {
      await database.insert(
        tableIntervals,
        IntervalModel(minute: 15).toMap(),
      );
      await database.insert(
        tableIntervals,
        IntervalModel(minute: 30, selected: true).toMap(),
      );
      await database.insert(
        tableIntervals,
        IntervalModel(minute: 60).toMap(),
      );
      await database.insert(
        tableIntervals,
        IntervalModel(minute: 120).toMap(),
      );
    }
  }
}
