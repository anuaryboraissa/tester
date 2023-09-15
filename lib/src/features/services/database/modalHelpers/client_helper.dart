import 'package:erisiti/src/features/services/database/modals/receipt.dart';

import '../dbHelpers/client.dart';

class ClientHelper {
  final ClientDbHelper _dbHelper = ClientDbHelper();

  Future<int> insert(ClientProfile client) async {
    return _dbHelper.insert(toMap(client));
  }

  Future<ClientProfile?> queryByTinNumber(String tinNumber, int id) async {
    print("query results ${await _dbHelper.queryByTinNumber(tinNumber, id)}");
    return fromMap(await _dbHelper.queryByTinNumber(tinNumber, id));
  }

  Future<List<ClientProfile?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(String tinNumber) async {
    return _dbHelper.delete(tinNumber);
  }

  Future<int> update(ClientProfile client) async {
    return _dbHelper.update(toMap(client));
  }

  Map<String, dynamic> toMap(ClientProfile client) {
    return {
      ClientDbHelper.columnClientId: client.id,
      ClientDbHelper.columnClientCreatedAt: client.createdAt,
      ClientDbHelper.columnClientCreatedBy: client.createdBy,
      ClientDbHelper.columnClientUpdatedAt: client.updatedAt,
      ClientDbHelper.columnClientDeleted: client.deleted,
      ClientDbHelper.columnClientFullName: client.fullName,
      ClientDbHelper.columnClientPhone: client.phone,
      ClientDbHelper.columnClientUserType: client.userType,
      ClientDbHelper.columnClientUsername: client.username,
      ClientDbHelper.columClientTinNumber: client.tinNumber,
      ClientDbHelper.columnClientUpdatedBy: client.updatedBy,
      ClientDbHelper.columnClientUuid: client.uuid
    };
  }

  ClientProfile? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : ClientProfile(
            createdAt: map[ClientDbHelper.columnClientCreatedAt],
            createdBy: map[ClientDbHelper.columnClientCreatedBy],
            updatedAt: map[ClientDbHelper.columnClientUpdatedAt],
            updatedBy: map[ClientDbHelper.columnClientUpdatedBy],
            deleted: map[ClientDbHelper.columnClientDeleted],
            fullName: map[ClientDbHelper.columnClientFullName],
            id: map[ClientDbHelper.columnClientId],
            phone: map[ClientDbHelper.columnClientPhone],
            tinNumber: map[ClientDbHelper.columClientTinNumber],
            userType: map[ClientDbHelper.columnClientUserType],
            username: map[ClientDbHelper.columnClientUsername],
            uuid: map[ClientDbHelper.columnClientUuid]);
  }
}
