import '../dbHelpers/receipt.dart';
import '../modals/receipt.dart';

class ReceiptHelper {
  final ReceiptDbHelper _dbHelper = ReceiptDbHelper();

  Future<int> insert(ReceiptModal receipt) async {
    return _dbHelper.insert(toMap(receipt));
  }

  Future<ReceiptModal?> queryByReceiptNumber(String receiptNumber) async {
    return fromMap(await _dbHelper.queryByReceiptNumber(receiptNumber));
  }

  Future<List<ReceiptModal?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<List<ReceiptModal?>> queryReceiptByBusiness(int businessId) async {
    List<Map<String, dynamic>> reportMapList =
        await _dbHelper.queryByBusinessId(businessId);
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<List<ReceiptModal?>> queryReceiptByTinNumber(String tinNumber) async {
    List<Map<String, dynamic>> reportMapList =
        await _dbHelper.queryReceiptsByTin(tinNumber);
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(String receiptNumber) async {
    return _dbHelper.delete(receiptNumber);
  }

  Future<int> update(ReceiptModal receipt) async {
    return _dbHelper.update(toMap(receipt));
  }

  Map<String, dynamic> toMap(ReceiptModal receipt) {
    return {
      ReceiptDbHelper.columnReceiptId: receipt.id,
      ReceiptDbHelper.columnBusinessId: receipt.businessProfile,
      ReceiptDbHelper.columnClientId: receipt.clientProfile,
      ReceiptDbHelper.columnReceiptActive: receipt.active,
      ReceiptDbHelper.columnReceiptAmount: receipt.amount,
      ReceiptDbHelper.columnReceiptCreatedAt: receipt.createdAt,
      ReceiptDbHelper.columnReceiptCreatedBy: receipt.createdBy,
      ReceiptDbHelper.columnReceiptUpdatedAt: receipt.updatedAt,
      ReceiptDbHelper.columnReceiptUpdatedBy: receipt.updatedBy,
      ReceiptDbHelper.columnReceiptReceiptNumber: receipt.receiptNumber,
      ReceiptDbHelper.columnReceiptTozo: receipt.tozo,
      ReceiptDbHelper.columnReceiptDeleted: receipt.deleted,
      ReceiptDbHelper.columnReceiptUuid: receipt.uuid,
      ReceiptDbHelper.columnReceiptVat: receipt.vat
    };
  }

  ReceiptModal? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : ReceiptModal(
            active: map[ReceiptDbHelper.columnReceiptActive],
            amount: map[ReceiptDbHelper.columnReceiptAmount],
            businessProfile: map[ReceiptDbHelper.columnBusinessId],
            clientProfile: map[ReceiptDbHelper.columnClientId],
            deleted: map[ReceiptDbHelper.columnReceiptDeleted],
            id: map[ReceiptDbHelper.columnReceiptId],
            receiptNumber: map[ReceiptDbHelper.columnReceiptReceiptNumber],
            tozo: map[ReceiptDbHelper.columnReceiptTozo],
            uuid: map[ReceiptDbHelper.columnReceiptUuid],
            vat: map[ReceiptDbHelper.columnReceiptVat],
            createdAt: map[ReceiptDbHelper.columnReceiptCreatedAt],
            createdBy: map[ReceiptDbHelper.columnReceiptCreatedBy],
            updatedAt: map[ReceiptDbHelper.columnReceiptUpdatedAt],
            updatedBy: map[ReceiptDbHelper.columnReceiptUpdatedBy]);
  }
}
