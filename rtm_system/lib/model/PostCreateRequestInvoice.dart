
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateRequestInvoice{

  createRequestInvoice(String token, int id, String sellDate) async {
    print(Uri.http('${url_main}', '${url_createRequestInvoice}'));
    final response = await http.post(
      Uri.http('${url_main}', '${url_createRequestInvoice}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "product_id": id,
        "sell_date": sellDate,
      }),
    );
    print("Status postApi CreateInvoice:${response.statusCode}");
    return response.statusCode;
  }

}
