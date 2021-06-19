
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutSignInvoice{

  putSignInvoice(String token, String id) async {
    final response = await http.put(
      Uri.http('${url_main}', '${url_signInvoice}/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "invoice_id": id,
      }),
    );
    print("Status putSignInvoice :${response.statusCode}");
    return response.statusCode;
  }

}
