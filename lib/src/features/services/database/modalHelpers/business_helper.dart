import 'package:erisiti/src/features/services/database/dbHelpers/business.dart';
import 'package:erisiti/src/features/services/database/modals/receipt.dart';

class BusinessHelper {
  final BusinessDbHelper _dbHelper = BusinessDbHelper();

  Future<int> insert(BusinessProfile business) async {
    return _dbHelper.insert(toMap(business));
  }

  Future<BusinessProfile?> queryByBusinessNumber(String businessNumber) async {
    return fromMap(await _dbHelper.queryByBusinessNumber(businessNumber));
  }

  Future<List<BusinessProfile?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(String businessNumber) async {
    return _dbHelper.delete(businessNumber);
  }

  Future<int> update(BusinessProfile business) async {
    return _dbHelper.update(toMap(business));
  }

  Map<String, dynamic> toMap(BusinessProfile business) {
    return {
      BusinessDbHelper.columnBusinessId: business.id,
      BusinessDbHelper.columnBusinessActive: business.active,
      BusinessDbHelper.columnBusinessCreatedBy: business.createdBy,
      BusinessDbHelper.columnBusinessCreatedAt: business.createdAt,
      BusinessDbHelper.columnBusinessDeleted: business.deleted,
      BusinessDbHelper.columnBusinessName: business.businessName,
      BusinessDbHelper.columnBusinessUpdatedAt: business.updatedAt,
      BusinessDbHelper.columnBusinessUpdatedBy: business.updatedBy,
      BusinessDbHelper.columnBusinessDistrict: business.district,
      BusinessDbHelper.columnBusinessRegion: business.region,
      BusinessDbHelper.columnBusinessTinNo: business.tinNumber,
      BusinessDbHelper.columnBusinessType: business.businessType,
      BusinessDbHelper.columnBusinessRegNumber: business.businessRegNumber,
      BusinessDbHelper.columnBusinessUuid: business.uuid
    };
  }

  BusinessProfile? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : BusinessProfile(
            active: map[BusinessDbHelper.columnBusinessActive],
            businessName: map[BusinessDbHelper.columnBusinessName],
            businessRegNumber: map[BusinessDbHelper.columnBusinessRegNumber],
            createdAt: map[BusinessDbHelper.columnBusinessCreatedAt],
            deleted: map[BusinessDbHelper.columnBusinessDeleted],
            district: map[BusinessDbHelper.columnBusinessDistrict],
            id: map[BusinessDbHelper.columnBusinessId],
            region: map[BusinessDbHelper.columnBusinessRegion],
            tinNumber: map[BusinessDbHelper.columnBusinessTinNo],
            uuid: map[BusinessDbHelper.columnBusinessUuid],
            businessType: map[BusinessDbHelper.columnBusinessType],
            createdBy: map[BusinessDbHelper.columnBusinessCreatedBy],
            updatedAt: map[BusinessDbHelper.columnBusinessCreatedAt],
            updatedBy: map[BusinessDbHelper.columnBusinessUpdatedBy]);
  }
}
