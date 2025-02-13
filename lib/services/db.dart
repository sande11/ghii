import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/repo.dart';

class DatabaseService {
  static Database? _database;
  static const String tableName = 'repositories';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'repos.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          fullname TEXT,
          private INTEGER,
          login TEXT,
          avatar_url TEXT,
          type TEXT,
          description TEXT
        )
      ''');
    });
  }

  static Future<void> insertRepository(Repository repo) async {
    final db = await database;
    await db.insert(
      tableName,
      repo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Repository>> getRepositories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return maps.map((map) => Repository.fromMap(map)).toList();
  }

  static Future<void> deleteRepository(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
