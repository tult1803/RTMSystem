
import 'dart:convert';
import 'package:rtm_system/ultils/src/url_api.dart';
import 'package:http/http.dart' as http;


class PutProcessAdvanceBill{
  putProcessAdvanceBill(String token, {String id, int status, String reason}) async {
    final response = await http.put(
      Uri.http('$urlMain', '$urlProcessAdvanceBill'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "status_id": status,
        "reason": "$reason",
      }),
    );
    print('$status');
    print('putAPI ProcessAdvanceBill: ${response.statusCode}');
    return response.statusCode;
  }

}
