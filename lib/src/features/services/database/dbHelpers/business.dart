import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BusinessDbHelper {
  BusinessDbHelper._internal();

  static BusinessDbHelper instance = BusinessDbHelper._internal();

  factory BusinessDbHelper() {
    return instance;
  }

  static const dbName = "erisiti.db";
  static const dbVersion = 1;

  static const tableBusiness = "business";
  static const columnBusinessId = "id";
  static const columnBusinessCreatedAt = "createdAt";
  static const columnBusinessUpdatedAt = "updatedAt";
  static const columnBusinessCreatedBy = "createdBy";
  static const columnBusinessUpdatedBy = "updatedBy";
  static const columnBusinessDeleted = "deleted";
  static const columnBusinessUuid = "uuid";
  static const columnBusinessActive = "active";
  static const columnBusinessRegNumber = "number";
  static const columnBusinessName = "name";
  static const columnBusinessType = "businessType";
  static const columnBusinessTinNo = "businessTin";
  static const columnBusinessDistrict = "district";
  static const columnBusinessRegion = "region";

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
    return db.insert(tableBusiness, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    tableCreate(db);
    return db.query(tableBusiness);
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

  // Future<List<Map<String, dynamic>>> queryAdmins(int groupId) async {
  //   Database db = await _instance.database;
  //   return db.rawQuery(
  //       "SELECT * FROM $tableName AS u INNER JOIN Admins AS a ON u.userId=a.userId INNER JOIN Groups AS g ON g.grpId=a.grpId WHERE g.grpId=?",
  //       [groupId]);
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

  Future<Map<String, dynamic>?> queryByBusinessNumber(
      String businessNumber) async {
    Database db = await instance.database;
    // dropTable(db);
    tableCreate(db);

    List<Map<String, dynamic>> results = await db.query(tableBusiness,
        where: '$columnBusinessRegNumber = ?', whereArgs: [businessNumber]);
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
      tableBusiness,
      row,
      where: '$columnBusinessRegNumber = ?',
      whereArgs: [row["regNumber"]],
    );
  }

  Future<int> delete(String businessNumber) async {
    Database db = await instance.database;
    return db.delete(tableBusiness,
        where: '$columnBusinessRegNumber = ?', whereArgs: [businessNumber]);
  }

  tableCreate(Database db) async {
    await db.execute("""
            CREATE TABLE IF NOT EXISTS $tableBusiness(
                $columnBusinessId INTEGER PRIMARY KEY,
                $columnBusinessCreatedAt TEXT,
                $columnBusinessCreatedBy TEXT,
                $columnBusinessUuid TEXT NOT NULL,
                $columnBusinessDeleted INTEGER NOT NULL,
                $columnBusinessActive INTEGER NOT NULL,
                $columnBusinessRegNumber TEXT NOT NULL,
                $columnBusinessUpdatedAt TEXT,
                $columnBusinessUpdatedBy TEXT,
                $columnBusinessDistrict TEXT NOT NULL,
                $columnBusinessName TEXT NOT NULL,
                $columnBusinessRegion TEXT NOT NULL,
                $columnBusinessType TEXT,
                $columnBusinessTinNo TEXT NOT NULL
              )
           """);
  }

  dropTable(Database db) async {
    await db.execute("DROP TABLE $tableBusiness");
  }
}
