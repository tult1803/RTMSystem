
import 'dart:convert';
import 'package:rtm_system/ultils/helpers.dart';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PostCreateRequestInvoice{

  createRequestInvoice(String token, String id, String sellDate) async {
    final response = await http.post(
      Uri.http('$urlMain', '$urlCreateRequestInvoice'),
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
