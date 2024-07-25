import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  static final SQLiteService _instance = SQLiteService._internal();

  factory SQLiteService() {
    return _instance;
  }

  SQLiteService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'flower_store.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE avatar (id INTEGER PRIMARY KEY, link TEXT)",
        );
      },
    );
  }

  Future<void> saveAvatarLink(String link) async {
    final db = await database;
    await db.insert(
      'avatar',
      {'link': link},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getAvatarLink() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('avatar');
    if (maps.isNotEmpty) {
      return maps.first['link'];
    }
    return null;
  }

  Future<void> updateAvatarLink(String link) async {
    final db = await database;
    await db.update(
      'avatar',
      {'link': link},
      where: 'id = ?',
      whereArgs: [1], // Assuming there's only one row with ID = 1
    );
  }
}
