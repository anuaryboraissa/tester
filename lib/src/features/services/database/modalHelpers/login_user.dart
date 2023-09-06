import 'package:erisiti/src/features/services/database/dbHelpers/login_user.dart';
import 'package:erisiti/src/features/services/database/modals/login_user.dart';

import 'dop_database.dart';

class LoginUserHelper {
  final LoginUserDbHelper _dbHelper = LoginUserDbHelper();

  Future<int> insert(LoginUser user) async {
    return _dbHelper.insert(toMap(user));
  }

  Future<LoginUser?> queryById(int id) async {
    return fromMap(await _dbHelper.queryById(id));
  }

  Future<List<LoginUser?>> queryAll() async {
    List<Map<String, dynamic>> reportMapList = await _dbHelper.queryAll();
    return reportMapList.map((e) => fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    return _dbHelper.delete(id);
  }

  Future<int> update(LoginUser loginUser) async {
    return _dbHelper.update(toMap(loginUser));
  }

  Map<String, dynamic> toMap(LoginUser user) {
    return {
      LoginUserDbHelper.columnTinNumber: user.tinNumber,
      LoginUserDbHelper.columnFirstName: user.firstName,
      LoginUserDbHelper.columnLastName: user.lastName,
      LoginUserDbHelper.columnPhoneNumber: user.phoneNumber,
      LoginUserDbHelper.columnUserType: user.userType,
      LoginUserDbHelper.columnToken: user.token,
      LoginUserDbHelper.columnRefreshToken: user.refreshToken
    };
  }

  LoginUser? fromMap(Map<String, dynamic>? map) {
    return map == null
        ? null
        : LoginUser(
            firstName: map[LoginUserDbHelper.columnFirstName],
            tinNumber: map[LoginUserDbHelper.columnTinNumber],
            lastName: map[LoginUserDbHelper.columnLastName],
            phoneNumber: map[LoginUserDbHelper.columnPhoneNumber],
            userType: map[LoginUserDbHelper.columnUserType],
            token: map[LoginUserDbHelper.columnToken],
            refreshToken: map[LoginUserDbHelper.columnRefreshToken]);
  }

  dropDatabase() {
    final DropDbHelper dropDbHelper = DropDbHelper();
    dropDbHelper.dropDatabase();
  }
}
