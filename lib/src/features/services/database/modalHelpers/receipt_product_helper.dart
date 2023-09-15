import '../dbHelpers/receipt_product.dart';
import '../modals/receipt.dart';

class ReceiptProductHelper {
  final ReceiptProductDbHelper _dbHelper = ReceiptProductDbHelper();

  Future<int> insert(ReceiptProducts receipt) async {
    return _dbHelper.insert(toMap(receipt));
  }

  Future<ReceiptProducts?> queryByReceiptProduct(
      String receiptNumber, int productId) async {
    return fromMap(
        await _dbHelper.queryProductReceipt(receiptNumber, productId));
  }

  Future<List<ReceiptProducts?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<List<ReceiptProducts?>> queryReceiptProducts(
      String receiptNumber) async {
    List<Map<String, dynamic>> reportMapList =
        await _dbHelper.queryReceiptProducts(receiptNumber);
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  // Future<List<ReceiptProducts?>> queryReceiptByBusiness(int businessId) async {
  //   List<Map<String, dynamic>> reportMapList =
  //       await _dbHelper.queryByBusinessId(businessId);
  //   return reportMapList.map((e) => fromMap(e)).toList();
  // }

  Future<int> delete(String receiptNumber, int productId) async {
    return _dbHelper.delete(receiptNumber, productId);
  }

  Future<int> update(ReceiptProducts receipt) async {
    return _dbHelper.update(toMap(receipt));
  }

  Map<String, dynamic> toMap(ReceiptProducts receipt) {
    return {
      ReceiptProductDbHelper.columnProductId: receipt.productId,
      ReceiptProductDbHelper.columnReceiptNumber: receipt.receiptNumber
    };
  }

  ReceiptProducts? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : ReceiptProducts(
            productId: map[ReceiptProductDbHelper.columnProductId],
            receiptNumber: map[ReceiptProductDbHelper.columnReceiptNumber]);
  }
}
