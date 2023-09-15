import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReceiptDbHelper {
  ReceiptDbHelper._internal();

  static ReceiptDbHelper instance = ReceiptDbHelper._internal();

  factory ReceiptDbHelper() {
    return instance;
  }

  static const dbName = "erisiti.db";
  static const dbVersion = 1;

  static const tableReceipt = "receipt";
  static const columnReceiptId = "id";
  static const columnReceiptCreatedAt = "createdAt";
  static const columnReceiptUpdatedAt = "updatedAt";
  static const columnReceiptCreatedBy = "createdBy";
  static const columnReceiptUpdatedBy = "updatedBy";
  static const columnReceiptDeleted = "deleted";
  static const columnReceiptUuid = "uuid";
  static const columnReceiptActive = "active";
  static const columnReceiptReceiptNumber = "number";
  static const columnReceiptAmount = "amount";
  static const columnReceiptVat = "vat";
  static const columnReceiptTozo = "Tozo";
  static const columnBusinessId = "businessId";
  static const columnClientId = "clientId";

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

  FutureOr<void> _onCreate(Database db, int version) {}

  FutureOr<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.insert(tableReceipt, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    tableCreate(db);
    return db.query(tableReceipt);
  }

  Future<List<Map<String, dynamic>>> queryByBusinessId(int businessId) async {
    Database db = await instance.database;
    return db.rawQuery(
        "SELECT * FROM $tableReceipt WHERE $columnBusinessId=?", [businessId]);
  }

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

  Future<Map<String, dynamic>?> queryByReceiptNumber(
      String receiptNumber) async {
    Database db = await instance.database;
    // dropTable(db);
    tableCreate(db);
    List<Map<String, dynamic>> results = await db.query(tableReceipt,
        where: '$columnReceiptReceiptNumber = ?', whereArgs: [receiptNumber]);
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
      tableReceipt,
      row,
      where: '$columnReceiptReceiptNumber = ?',
      whereArgs: [row[tableReceipt]],
    );
  }

  Future<int> delete(String receiptNumber) async {
    Database db = await instance.database;
    return db.delete(tableReceipt,
        where: '$columnReceiptReceiptNumber = ?', whereArgs: [receiptNumber]);
  }

  tableCreate(Database db) async {
    await db.execute("""
            CREATE TABLE IF NOT EXISTS $tableReceipt(
                $columnReceiptId INTEGER PRIMARY KEY,
                $columnReceiptCreatedAt TEXT NOT NULL,
                $columnReceiptCreatedBy TEXT,
                $columnReceiptAmount DOUBLE NOT NULL,
                $columnReceiptDeleted INTEGER NOT NULL,
                $columnReceiptActive INTEGER NOT NULL,
                $columnReceiptReceiptNumber TEXT NOT NULL,
                $columnReceiptUpdatedAt TEXT,
                $columnReceiptUpdatedBy TEXT,
                $columnReceiptTozo DOUBLE NOT NULL,
                $columnReceiptUuid TEXT NOT NULL,
                $columnBusinessId INTEGER NOT NULL,
                $columnClientId INTEGER NOT NULL,
                $columnReceiptVat DOUBLE NOT NULL
              )
           """);
  }

  dropTable(Database db) async {
    await db.execute("DROP TABLE $tableReceipt");
  }
}
