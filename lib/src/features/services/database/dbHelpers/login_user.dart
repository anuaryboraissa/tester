import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginUserDbHelper {
  LoginUserDbHelper._constructor();

  static const tableName = 'loggedIn';

  static const columnId = 'id';
  static const columnTinNumber = 'tinNumber';
  static const columnFullName = "fullName";
  static const columnPhoneNumber = "phone";
  static const columnUserType = "userType";
  static const columnToken = "token";
  static const columnRefreshToken = "refreshToken";
  factory LoginUserDbHelper() {
    return instance;
  }
  static final LoginUserDbHelper instance = LoginUserDbHelper._constructor();

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

  Future _onCreate(Database db, int version) async {
    tableCreate(db);
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    tableCreate(db);
    return db.query(tableName);
  }

  Future<Map<String, dynamic>?> queryById(int id) async {
    Database db = await instance.database;
    tableCreate(db);
    List<Map<String, dynamic>> results =
        await db.query(tableName, where: '$columnId = ?', whereArgs: [id]);

    return results.isEmpty ? null : results.single;
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [row[columnId]],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  tableCreate(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnTinNumber  TEXT NOT NULL,
      $columnFullName TEXT NOT NULL,
      $columnPhoneNumber TEXT NOT NULL,
      $columnUserType TEXT NOT NULL,
      $columnToken TEXT NOT NULL,
      $columnRefreshToken TEXT NOT NULL
      )
      ''');
  }
}
