import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ClientDbHelper {
  ClientDbHelper._internal();

  static ClientDbHelper instance = ClientDbHelper._internal();

  factory ClientDbHelper() {
    return instance;
  }
  static const dbName = "erisiti.db";
  static const dbVersion = 1;

  static const tableClient = "client";
  static const columnClientId = "id";
  static const columnClientCreatedAt = "createdAt";
  static const columnClientUpdatedAt = "updatedAt";
  static const columnClientCreatedBy = "createdBy";
  static const columnClientUpdatedBy = "updatedBy";
  static const columnClientDeleted = "deleted";
  static const columnClientFullName = "full_name";
  static const columnClientUsername = "username";
  static const columClientTinNumber = "tinNumber";
  static const columnClientPhone = "phone";
  static const columnClientUserType = "type";
  static const columnClientUuid = "uuid";
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
    String path = join(directory, dbName);
    return openDatabase(path,
        version: dbVersion, onCreate: _onCreate, onConfigure: _onConfigure);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    tableCreate(db);
  }

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.insert(tableClient, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    tableCreate(db);
    return db.query(tableClient);
  }

  // Future<List<Map<String, dynamic>>> queryUserDetails(String log) async {
  //   Database db = await instance.database;
  //   return db.rawQuery(
  //       "SELECT * FROM $tableReceipt AS u INNER JOIN Messages AS m ON u.$columnUserId=m.sender WHERE M.receiver=?",
  //       [log]);
  // }

  // Future<List<Map<String, dynamic>>> queryParticipants(int groupId) async {
  //   Database db = await _instance.database;
  //   return db.rawQuery(
  //       "SELECT * FROM $tableName AS u INNER JOIN Participants AS p ON u.userId=p.part_userId INNER JOIN Groups AS g ON g.grpId=p.part_grpId WHERE g.grpId=?",
  //       [groupId]);
  // }

  // Future<List<Map<String, dynamic>>> queryActiveFriends(int days)async{
  //       Database db = await _instance.database;
  //       var format = DateFormat("yyyy-MM-dd HH:mm");
  //       var now = format.format(DateTime.now());
  //        return db.rawQuery(
  //       "SELECT * FROM $tableName AS u INNER JOIN $tableName2 AS a ON u.$columnUserId=a.$columnUserId2 WHERE ${DateTime.parse('a.$columDate').difference(DateTime.parse(now)).inDays} <= ?",[days]
  //       );
  // }

  // Future<List<Map<String, dynamic>>> queryBusinessClients(
  //     String businessNumber) async {
  //   Database db = await instance.database;
  //   return db.rawQuery(
  //       "SELECT * FROM $tableClient WHERE $columnBusinessRegNumber=?",
  //       [businessNumber]);
  // }

  // Future<Map<String, dynamic>?> queryByFields(
  //     String firstName, String lastName, String phone) async {
  //   Database db = await _instance.database;
  //   List<Map<String, dynamic>> results = await db.query(tableName,
  //       where: '$columnFirstName=? and $columLastName=? and $columnPhone=?',
  //       whereArgs: [firstName, lastName, phone]);
  //   print("result yake ni $phone $results...............................");
  //   return results.isEmpty ? null : results.single;
  // }

  Future<Map<String, dynamic>?> queryByTinNumber(
      String tinNumber, int id) async {
    Database db = await instance.database;
    // dropTable(db);
    tableCreate(db);
    List<Map<String, dynamic>> results = await db.query(tableClient,
        where: '$columClientTinNumber = ? or $columnClientId=?',
        whereArgs: [tinNumber, id]);

    return results.isEmpty ? null : results.single;
  }

  // Future<Map<String, dynamic>?> queryByPhone(String phone) async {
  //   Database db = await _instance.database;
  //   tableCreate(db);
  //   List<Map<String, dynamic>> results = await db
  //       .query(tableName, where: '$columnPhone = ?', whereArgs: [phone]);
  //   return results.isEmpty ? null : results.single;
  // }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.update(
      tableClient,
      row,
      where: '$columnClientId = ?',
      whereArgs: [row["id"]],
    );
  }

  Future<int> delete(String tinNumber) async {
    Database db = await instance.database;
    return db.delete(tableClient,
        where: '$columClientTinNumber = ?', whereArgs: [tinNumber]);
  }

  tableCreate(Database db) async {
    await db.execute("""
            CREATE TABLE IF NOT EXISTS $tableClient(
                $columnClientId INTEGER,
                $columnClientCreatedAt TEXT NOT NULL,
                $columnClientCreatedBy TEXT,
                $columnClientFullName TEXT NOT NULL,
                $columnClientDeleted INTEGER NOT NULL,
                $columnClientPhone TEXT NOT NULL,
                $columnClientUpdatedAt TEXT,
                $columnClientUpdatedBy TEXT,
                $columnClientUserType TEXT NOT NULL,
                $columnClientUsername TEXT NOT NULL,
                $columnClientUuid TEXT NOT NULL,
                $columClientTinNumber TEXT PRIMARY KEY
              )
           """);
  }

  dropTable(Database db) async {
    await db.execute("DROP TABLE $tableClient");
  }
}
