import "dart:convert";

import "package:http/http.dart" as http;

class RegisterBusinessService {
  static Future<Map> registerBusiness(String businessName, String region,
      String district, String businessReg, String tinNumber) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var result = http
          .post(
              Uri.parse(
                  "http://172.17.17.141:8081/api/v1/add-business-profile"),
              body: json.encode({
                "businessName": businessName,
                "region": region,
                "district": district,
                "businessRegistrationNumber": businessReg,
                "tinNo": tinNumber
              }),
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
