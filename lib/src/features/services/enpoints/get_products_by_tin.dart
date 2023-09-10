import "dart:convert";

import "package:http/http.dart" as http;

class FindProductsService {
  static Future<Map> getProductsByBusinessNumber(int businessNumber) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var result = http
          .get(
              Uri.parse(
                  "http://172.17.17.141:8081/api/v1/get-business-products/$businessNumber"),
              headers: headers)
          .then((value) {
        if (value.statusCode == 200) {
          return json.decode(value.body);
        } else {
          return {
            "error": false,
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
        "error": false,
        "code": 5100,
        "data": null,
        "dataList": null,
        "message": "$e"
      };
    }
  }
}
