import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DropDbHelper {
  DropDbHelper._constructor();

  factory DropDbHelper() {
    return instance;
  }
  static final DropDbHelper instance = DropDbHelper._constructor();

  static const _dbName = 'erisiti.db';
  static const _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future _onCreate(Database db, int version) async {}

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  dropDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _dbName);
    await deleteDatabase(path);
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
