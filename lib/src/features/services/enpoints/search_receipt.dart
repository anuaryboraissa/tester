import 'dart:convert';

import 'package:http/http.dart' as http;

class SearchReceiptService {
  Future<Map> searchReceipt(
      String tinNumber, String startDate, String endDate) async {
    try {
      String url = 'http://172.17.17.223/erisiti/user_dashboard/receipt.php';
      var answer = http
          .post(Uri.parse(url),
              body: json.encode({
                "tinNumber": tinNumber,
                "startDate": startDate,
                "endDate": endDate
              }))
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
