import 'package:erisiti/src/features/services/database/dbHelpers/products.dart';
import 'package:erisiti/src/features/services/database/modals/receipt.dart';

class ProductHelper {
  final ProductDbHelper _dbHelper = ProductDbHelper();

  Future<int> insert(ReceiptItem item) async {
    return _dbHelper.insert(toMap(item));
  }

  Future<ReceiptItem?> queryById(int itemId) async {
    return fromMap(await _dbHelper.queryById(itemId));
  }

  Future<List<ReceiptItem?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<List<ReceiptItem?>> queryBusinessItems(String businessNumber) async {
    List<Map<String, dynamic>> reportMapList =
        await _dbHelper.queryBusinessProducts(businessNumber);
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<List<ReceiptItem?>> queryReceiptProducts(String receiptNumber) async {
    List<Map<String, dynamic>> reportMapList =
        await _dbHelper.queryReceiptProducts(receiptNumber);
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(int itemId) async {
    return _dbHelper.delete(itemId);
  }

  Future<int> update(ReceiptItem item) async {
    return _dbHelper.update(toMap(item));
  }

  Map<String, dynamic> toMap(ReceiptItem item) {
    return {
      ProductDbHelper.columnProductId: item.id,
      ProductDbHelper.columnBusinessRegNumber: item.businessRegNumber,
      ProductDbHelper.columnProductActive: item.active,
      ProductDbHelper.columnProductAmount: item.amount,
      ProductDbHelper.columnProductCreatedAt: item.createdAt,
      ProductDbHelper.columnProductCreatedBy: item.createdBy,
      ProductDbHelper.columnProductDeleted: item.deleted,
      ProductDbHelper.columnProductName: item.productName,
      ProductDbHelper.columnProductUpdatedAt: item.updatedAt,
      ProductDbHelper.columnProductUpdatedBy: item.updatedBy,
      ProductDbHelper.columnProductUuid: item.uuid
    };
  }

  ReceiptItem? fromMap(Map<String, dynamic>? map) {
    print("from map active ${map![ProductDbHelper.columnProductActive]}");
    print("from map amount ${map[ProductDbHelper.columnProductAmount]}");
    print("from map reg ${map[ProductDbHelper.columnBusinessRegNumber]}");
    print("from map created ${map[ProductDbHelper.columnProductCreatedAt]}");
    print("from map id ${map[ProductDbHelper.columnProductId]}");
    return map == null
        ? null
        : ReceiptItem(
            active: map[ProductDbHelper.columnProductActive],
            amount: map[ProductDbHelper.columnProductAmount],
            businessRegNumber: map[ProductDbHelper.columnBusinessRegNumber],
            createdAt: map[ProductDbHelper.columnProductCreatedAt],
            createdBy: map[ProductDbHelper.columnProductCreatedBy],
            deleted: map[ProductDbHelper.columnProductDeleted],
            id: map[ProductDbHelper.columnProductId],
            productName: map[ProductDbHelper.columnProductName],
            updatedAt: map[ProductDbHelper.columnProductUpdatedAt],
            updatedBy: map[ProductDbHelper.columnProductUpdatedBy],
            uuid: map[ProductDbHelper.columnProductUuid]);
  }
}
