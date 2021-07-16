
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutReturnAdvance{
  putReturnAdvance(String token, List<String> invoiceId, List<String> advanceId) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlReturnAdvance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "invoices": invoiceId,
        "advances": advanceId,
      }),
    );
    return response.statusCode;
  }

}
