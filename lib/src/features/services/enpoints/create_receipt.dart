import "dart:convert";

import "package:http/http.dart" as http;

class GenerateReceiptService {
  static Future<Map> generateReceipt(
      double totalAmount,
      double vat,
      double tozo,
      int businessId,
      String clientTinNumber,
      List<Map<String, dynamic>> products) async {
    print("products $products");
    try {
      var headers = {'Content-Type': 'application/json'};
      var result = http
          .post(Uri.parse("http://172.17.17.141:8081/api/v1/add-receipt"),
              body: json.encode({
                "amount": totalAmount,
                "vat": vat,
                "tozo": tozo,
                "businessProfileId": businessId,
                "tinNo": clientTinNumber,
                "products": products
              }),
              headers: headers)
          .then((value) {
        if (value.statusCode == 200) {
          print("ans");
          print(json.decode(value.body));
          return json.decode(value.body);
        } else {
          return {
            "error": false,
            "code": 5100,
            "products": null,
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
        "products": null,
        "dataList": null,
        "message": "$e"
      };
    }
  }
}
