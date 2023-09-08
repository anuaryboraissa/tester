import 'dart:convert';

import 'package:http/http.dart' as http;

class RegistrationService {
  //167845674

  Future<Map> registerUser(String tinNumber, String account, String password,
      String fullName, String phone) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var result = http
          .post(Uri.parse("http://172.17.17.141:8081/api/v1/auth/register"),
              body: json.encode({
                "fullName": fullName,
                "tinNo": tinNumber,
                "phoneNumber": phone,
                "userType": account,
                "password": password
              }),
              headers: headers)
          .then((value) {
        print("this is ${value.statusCode} and $value");
        if (value.statusCode == 200) {
          return json.decode(value.body);
        } else {
          return {
            "error": true,
            "code": 5100,
            "data": null,
            "dataList": null,
            "message": "Something went wrong"
          };
        }
      });
      return await result;
    } catch (e) {
      return {
        "error": true,
        "code": 5100,
        "data": null,
        "dataList": null,
        "message": "$e"
      };
    }
  }
}
