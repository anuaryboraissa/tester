import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductDbHelper {
  ProductDbHelper._internal();

  static ProductDbHelper instance = ProductDbHelper._internal();

  factory ProductDbHelper() {
    return instance;
  }
  static const dbName = "erisiti.db";
  static const dbVersion = 1;

  static const tableProduct = "Product";
  static const columnProductId = "id";
  static const columnProductCreatedAt = "createdAt";
  static const columnProductUpdatedAt = "updatedAt";
  static const columnProductCreatedBy = "createdBy";
  static const columnProductUpdatedBy = "updatedBy";
  static const columnProductDeleted = "deleted";
  static const columnProductUuid = "uuid";
  static const columnProductActive = "active";
  static const columnBusinessRegNumber = "businessNumber";
  static const columnProductName = "name";
  static const columnProductAmount = "amount";

  static const tableName = "ReceiptsProducts";
  static const columnId = "id";
  static const columnProductId2 = "product";
  static const columnReceiptNumber = "receipt";
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
    return db.insert(tableProduct, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    tableCreate(db);
    return db.query(tableProduct);
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

  Future<List<Map<String, dynamic>>> queryBusinessProducts(
      String businessNumber) async {
    Database db = await instance.database;
    // dropTable(db);
    return db.rawQuery(
        "SELECT * FROM $tableProduct WHERE $columnBusinessRegNumber=?",
        [businessNumber]);
  }

  Future<List<Map<String, dynamic>>> queryReceiptProducts(
      String receiptNumber) async {
    Database db = await instance.database;
    return db.rawQuery(
        "SELECT * FROM $tableProduct as p INNER JOIN $tableName as rp on p.$columnProductId=rp.$columnProductId2  WHERE rp.$columnReceiptNumber=?",
        [receiptNumber]);
  }

  // Future<Map<String, dynamic>?> queryByFields(
  //     String firstName, String lastName, String phone) async {
  //   Database db = await _instance.database;
  //   List<Map<String, dynamic>> results = await db.query(tableName,
  //       where: '$columnFirstName=? and $columLastName=? and $columnPhone=?',
  //       whereArgs: [firstName, lastName, phone]);
  //   print("result yake ni $phone $results...............................");
  //   return results.isEmpty ? null : results.single;
  // }

  Future<Map<String, dynamic>?> queryById(int id) async {
    Database db = await instance.database;
    // dropTable(db);
    tableCreate(db);
    List<Map<String, dynamic>> results = await db
        .query(tableProduct, where: '$columnProductId = ?', whereArgs: [id]);
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
      tableProduct,
      row,
      where: '$columnProductId = ?',
      whereArgs: [row["id"]],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return db
        .delete(tableProduct, where: '$columnProductId = ?', whereArgs: [id]);
  }

  tableCreate(Database db) async {
    await db.execute("""
            CREATE TABLE IF NOT EXISTS $tableProduct(
                $columnProductId INTEGER PRIMARY KEY,
                $columnProductCreatedAt TEXT NOT NULL,
                $columnProductCreatedBy TEXT,
                $columnProductUuid TEXT NOT NULL,
                $columnProductDeleted INTEGER NOT NULL,
                $columnProductActive INTEGER NOT NULL,
                $columnBusinessRegNumber TEXT NOT NULL,
                $columnProductUpdatedAt TEXT,
                $columnProductUpdatedBy TEXT,
                $columnProductAmount DOUBLE NOT NULL,
                $columnProductName TEXT NOT NULL
              )
           """);
    await db.execute("""
        CREATE TABLE IF NOT EXISTS $tableName(
          $columnId INTEGER AUTO INCREMENT PRIMARY KEY,
          $columnProductId2 INTEGER NOT NULL,
          $columnReceiptNumber TEXT NOT NULL
         )
      """);
  }

  dropTable(Database db) async {
    await db.execute("DROP TABLE $tableProduct");
  }
}
