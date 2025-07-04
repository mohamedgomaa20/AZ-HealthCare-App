import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WaterTrackingDB {
  static final WaterTrackingDB instance = WaterTrackingDB._init();
  static Database? _database;

  WaterTrackingDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('water_tracking.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE water_intake (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      timestamp INTEGER,
      amount INTEGER,
      glassType TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE daily_goal (
      date TEXT PRIMARY KEY,
      targetAmount INTEGER,
      achievedAmount INTEGER
    )
    ''');

    await db.execute('''
CREATE TABLE intervals (
  minute INTEGER PRIMARY KEY,
  selected INTEGER,
  displayName TEXT
)
''');

  }
}
