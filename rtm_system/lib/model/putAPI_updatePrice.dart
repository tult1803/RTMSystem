
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdatePrice{

  updatePrice(String token, int account_id, int product_id, double price) async {
    final response = await http.put(
      Uri.http('${url_main}', '${url_updatePrice}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "account_id": account_id,
        "product_id": product_id,
        "price": price,
      }),
    );
    print("Status putAPI Update Price:${response.statusCode}");
    return response.statusCode;
  }

}
