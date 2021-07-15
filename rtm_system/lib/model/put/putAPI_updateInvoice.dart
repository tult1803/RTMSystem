
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;

//Type = 0 là update Password, != 0 là updata dữ liệu khác
//CMND mà trống là update manager, ngược lại là update Customer
class PutUpdateInvoice{
  updateInvoice(String token, String id, double quantity, double degree) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlUpdateInvoice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "quantity": quantity,
        "degree": degree,
      }),
    );
    print('$id - $quantity - $degree');
    print("Status putAPI Update Invoice:${response.statusCode}");
    return response.statusCode;
  }

}
