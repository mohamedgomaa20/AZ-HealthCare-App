import 'package:az_health_care/features/step_tracker_v2/data/models/running_session.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/step_data.dart';

class DatabaseHelper {
  static const _databaseName = 'step_tracker.db';
  static const _databaseVersion = 1;

  static const tableStepData = 'step_data';
  static const tableRunningSessions = 'running_sessions';

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
     await db.execute('''
      CREATE TABLE $tableStepData (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        date TEXT NOT NULL,
        steps INTEGER NOT NULL DEFAULT 0,
        caloriesBurned INTEGER NOT NULL DEFAULT 0,
        distanceKm REAL NOT NULL DEFAULT 0.0,
        activeMinutes INTEGER NOT NULL DEFAULT 0,
      
        lastUpdated INTEGER NOT NULL
      )
    ''');

     await db.execute('''
      CREATE TABLE $tableRunningSessions (
        id TEXT PRIMARY KEY,
        startTime INTEGER NOT NULL,
        endTime INTEGER,
        steps INTEGER NOT NULL DEFAULT 0,
        distance REAL NOT NULL DEFAULT 0.0,
        caloriesBurned REAL NOT NULL DEFAULT 0.0,
        
        duration INTEGER NOT NULL DEFAULT 0,
        isActive INTEGER NOT NULL DEFAULT 0
      )
    ''');

     await db.execute('CREATE INDEX idx_step_data_date ON $tableStepData(date)');
    await db.execute(
      'CREATE INDEX idx_step_data_user ON $tableStepData(userId)',
    );
    await db.execute(
      'CREATE INDEX idx_running_sessions_date ON $tableRunningSessions(startTime)',
    );
  }

   static Future<int> insertStepData(StepData stepData) async {
    final db = await database;
    return await db.insert(
      tableStepData,
      stepData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<StepData?> getStepDataByDate(String date) async {
    final db = await database;
    final maps = await db.query(
      tableStepData,
      where: 'date = ?',
      whereArgs: [date],
    );

    if (maps.isNotEmpty) {
      return StepData.fromMap(maps.first);
    }
    return null;
  }

  static Future<List<StepData>> getStepDataRange(
    String startDate,
    String endDate,
  ) async {
    final db = await database;
    final maps = await db.query(
      tableStepData,
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
      orderBy: 'date',
    );

    return maps.map((map) => StepData.fromMap(map)).toList();
  }

  static Future<List<StepData>> getLastSevenDays() async {
    final db = await database;
    final maps = await db.query(tableStepData, orderBy: 'date DESC', limit: 7);

    return maps.map((map) => StepData.fromMap(map)).toList();
  }

  static Future<int> updateStepCount(
    String date,
    int steps,
    int caloriesBurned,
    double distanceKm,
    int activeMinutes,
  ) async {
    final db = await database;
    return await db.update(
      tableStepData,
      {
        'steps': steps,
        'caloriesBurned': caloriesBurned,
        'distanceKm': distanceKm,
        'activeMinutes': activeMinutes,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  static Future<int> updateDailyGoalForUser(String userId, int newGoal) async {
    final db = await database;
    return await db.update(
      tableStepData,
      {
        'dailyGoal': newGoal,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
  static Future<int> updateDailyGoalForDate(String date, int newGoal) async {
    final db = await database;
    return await db.update(
      tableStepData,
      {
        'dailyGoal': newGoal,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'date = ?',
      whereArgs: [date],
    );
  }

  static Future<int> getDailyGoal(String date) async {
    final db = await database;
    final maps = await db.query(
      tableStepData,
      columns: ['dailyGoal'],
      where: 'date = ?',
      whereArgs: [date],
    );

    if (maps.isNotEmpty) {
      return maps.first['dailyGoal'] as int;
    }
    return 10000;
  }


   static Future<int> insertRunningSession(RunningSession session) async {
    final db = await database;
    return await db.insert(
      tableRunningSessions,
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<RunningSession?> getActiveRunningSession() async {
    final db = await database;
    final maps = await db.query(
      tableRunningSessions,
      where: 'isActive = ?',
      whereArgs: [1],
    );

    if (maps.isNotEmpty) {
      return RunningSession.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> updateRunningSession(RunningSession session) async {
    final db = await database;
    return await db.update(
      tableRunningSessions,
      session.toMap(),
      where: 'id = ?',
      whereArgs: [session.id],
    );
  }

  static Future<List<RunningSession>> getRunningHistory() async {
    final db = await database;
    final maps = await db.query(
      tableRunningSessions,
      orderBy: 'startTime DESC',
      limit: 10,
    );

    return maps.map((map) => RunningSession.fromMap(map)).toList();
  }
}
