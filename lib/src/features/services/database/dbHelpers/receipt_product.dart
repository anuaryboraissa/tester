import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReceiptProductDbHelper {
  ReceiptProductDbHelper._internal();

  static ReceiptProductDbHelper instance = ReceiptProductDbHelper._internal();
  factory ReceiptProductDbHelper() {
    return instance;
  }

  static const dbName = "erisiti.db";
  static const dbVersion = 1;

  static const tableName = "ReceiptsProducts";
  static const columnId = "id";
  static const columnProductId = "product";
  static const columnReceiptNumber = "receipt";

  Database? db;

  Future<Database> get database async {
    if (db != null) {
      return db!;
    }
    db = await initializeDatabase();
    return db!;
  }

  Future<Database> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);
    return openDatabase(path,
        version: dbVersion, onConfigure: _onConfigure, onCreate: _onCreate);
  }

  FutureOr<void> _onConfigure(Database db) {
    tableCreate(db);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    tableCreate(db);
    return db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    tableCreate(db);
    return db.update(
      tableName,
      row,
      where: '$columnProductId = ? and $columnReceiptNumber=?',
      whereArgs: [row["productId"], row['receipt']],
    );
  }

  Future<Map<String, dynamic>?> queryProductReceipt(
      String receiptNumber, int productId) async {
    Database db = await instance.database;
    // dropTable(db);
    tableCreate(db);
    List<Map<String, dynamic>> results = await db.query(tableName,
        where: '$columnReceiptNumber = ? and $columnProductId=?',
        whereArgs: [receiptNumber, productId]);
    return results.isEmpty ? null : results.single;
  }

  Future<List<Map<String, dynamic>>> queryReceiptProducts(
      String receiptNumber) async {
    Database db = await instance.database;
    return db.rawQuery("SELECT * FROM $tableName WHERE $columnReceiptNumber=?",
        [receiptNumber]);
  }

  Future<int> delete(String receiptNumber, int productId) async {
    Database db = await instance.database;
    return db.delete(tableName,
        where: '$columnReceiptNumber = ? and $columnProductId=?',
        whereArgs: [receiptNumber, productId]);
  }

  tableCreate(Database database) async {
    await database.execute("""
        CREATE TABLE IF NOT EXISTS $tableName(
          $columnId INTEGER AUTO INCREMENT PRIMARY KEY,
          $columnProductId INTEGER NOT NULL,
          $columnReceiptNumber TEXT NOT NULL
         )
      """);
  }
}
