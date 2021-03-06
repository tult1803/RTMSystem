
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutSignInvoice{

  putSignInvoice(String token, List<String> id) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlSignInvoice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "invoice_ids": id,
      }),
    );
    return response.statusCode;
  }

}
