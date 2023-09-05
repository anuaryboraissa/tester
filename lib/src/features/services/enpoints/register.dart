import 'dart:convert';

import 'package:http/http.dart' as http;

class RegistrationService {
  //167845674

  Future<Map> registerUser(String tinNumber, String account, String password,
      String rptPassword) async {
    try {
      var result = http
          .post(
              Uri.parse("http://172.17.17.223/erisiti/registration/index.php"),
              body: json.encode({
                "tinNumber": tinNumber,
                "accountType": account,
                "password": password,
                "rptPassword": rptPassword
              }))
          .then((value) {
        if (value.statusCode == 200) {
          return json.decode(value.body);
        } else {
          return {"message": "something went wrong", "status": "fail"};
        }
      });
      return await result;
    } catch (e) {
      return {"message": "something went wrong $e", "status": "fail"};
    }
  }
}
