import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  Future<Map> login(String tinNumber, String password) async {
    try {
      String url = 'http://172.17.17.223/erisiti/registration/login.php';
      var answer = http
          .post(Uri.parse(url),
              body: json.encode({"tinNumber": tinNumber, "password": password}))
          .then((response) {
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);

          return jsonData;
        } else {
          return {
            "status": "fail",
            "message": "something wrong ",
          };
        }
      });
      return await answer;
    } catch (e) {
      return {
        "status": "fail",
        "message": "something wrong $e",
      };
      // loginStatus("fail", "something went wrong! $e");
    }
  }
}
