import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<Map> login(String tinNumber, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      String url = 'http://172.17.17.141:8081/api/v1/auth/login';
      var answer = http
          .post(Uri.parse(url),
              body: json.encode({"tinNo": tinNumber, "password": password}),
              headers: headers)
          .then((response) {
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          return jsonData;
        }
      });
      return await answer;
    } catch (e) {
      return {
        "error": false,
        "code": 5100,
        "data": null,
        "dataList": null,
        "message": "$e"
      };
      // loginStatus("fail", "something went wrong! $e");
    }
  }
}
