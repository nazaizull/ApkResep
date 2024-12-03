import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();

  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'recipes.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE recipes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            preparation_time TEXT,
            ingredients TEXT,
            instructions TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  Future<int> insertRecipe(Map<String, dynamic> recipe) async {
    final db = await database;
    return db.insert('recipes', recipe);
  }

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    final db = await database;
    return db.query('recipes');
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateRecipe(int id, Map<String, dynamic> recipe) async {
    final db = await database;
    return db.update('recipes', recipe, where: 'id = ?', whereArgs: [id]);
  }
}
